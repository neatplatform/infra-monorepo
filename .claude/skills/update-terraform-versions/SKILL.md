---
name: update-terraform-versions
description: >
  Bumps Terraform and provider versions to the latest stable releases across all versions.tf
  files in the repo, keeping each version constraint's existing style intact.
  Triggers when the user asks to update, upgrade, or check Terraform/provider versions.
---

# Update Terraform and provider versions

This repo pins Terraform and provider versions in a `terraform { ... }` block inside a file named `versions.tf`,
one per module/project. Two conventions coexist (see the header comment in each file):

  - **Reusable modules** (`modules/**/versions.tf`) set only a **minimum** version, using `>=`,
    e.g. `required_version = ">= 1.12.2"`, `version = ">= 6.11.1"`.
  - **Root modules / projects** (`projects/**/versions.tf`) set **both** a lower and upper bound
    via the pessimistic operator, e.g. `required_version = "~> 1.12"`, `version = "~> 6.0"`.

This skill only ever changes the version *numbers* inside these constraints.
It never changes the operator, never changes a `>=` file to `~>` or vice versa,
and never touches anything else in the file (comments, provider aliases, ordering, unrelated blocks).

## 1. Find the target(s)

  - If invoked with an argument that looks like a path,
    scope to that file (or every `versions.tf` under that directory) only.
  - Otherwise, find every file named exactly `versions.tf` in the repo:
    `find . -type f -name versions.tf`. Don't assume they only live under `modules/` and `projects/`.
    Search the whole repo so new top-level directories are picked up automatically.
  - If an argument contains `--dry-run`, do the full analysis and report but skip step 5 (no file edits).

## 2. Parse each file's terraform block

For each `versions.tf`, read the `terraform { ... }` block and extract:

  - `required_version = "<constraint>"`
  - Each entry under `required_providers`:
    the local name, its `source = "<namespace>/<name>"`, and its `version = "<constraint>"`.

For every constraint found, record its **shape**: the operator(s) (`~>`, `>=`, `>`, `=`, or a bare version)
and the number of numeric segments (2 = `major.minor`, 3 = `major.minor.patch`).
A constraint can also be compound, comma-separated (e.g. `">= 6.0, < 7.0.0"`) — 
record each clause's operator and segment count separately.

## 3. Look up the latest stable version

  - **Terraform CLI itself:**

    ```
    curl -s https://checkpoint-api.hashicorp.com/v1/check/terraform | jq -r .current_version
    ```

    If that's unreachable, fall back to the releases index and
    filter out anything with a `-` suffix (alpha/beta/rc), then sort as semver and take the highest:

    ```
    curl -s https://releases.hashicorp.com/terraform/index.json | jq -r '.versions | keys[]' | grep -Ev -- '-' | sort -V | tail -1
    ```

  - **Each provider**, using its `source` (`<namespace>/<name>`):

    ```
    curl -s "https://registry.terraform.io/v1/providers/<namespace>/<name>/versions" \
      | jq -r '.versions[].version' | grep -Ev -- '-' | sort -V | tail -1
    ```

    (The `-` filter excludes pre-releases like `7.0.0-beta1`; only stable releases count.)

Cache lookups per provider/Terraform within a single run — several `versions.tf` files in this repo
pin the same provider (e.g. `integrations/github`), so don't re-query the registry for every file.

## 4. Compute the new constraint, preserving shape

Given the current constraint's shape (from step 2) and the latest version `X.Y.Z` (from step 3):

  - **Operator stays exactly as-is.** Never change `~>` to `>=` or introduce/remove an upper bound —
    that's a deliberate module-vs-project convention, not something to "fix".
  - **Segment count stays as-is.** A 2-segment original (`major.minor`) becomes `OP X.Y` (drop the patch).
    A 3-segment original (`major.minor.patch`) becomes `OP X.Y.Z` (full version).
  - **Compound constraints** (comma-separated, e.g. `">= 6.0, < 7.0.0"`):
    update only the lower-bound clause (`>=`/`>`) the same way.
    If the resulting version would violate the existing upper-bound clause (`<`/`<=`),
    don't touch either clause — leave the file alone and flag it in the report as needing manual review,
    since raising the ceiling is a judgment call this skill shouldn't make silently.
  - **Bare/exact version** (no operator, or `=`):
    replace with the latest version at the same segment count.

If the new value's **major** version differs from the current major,
still apply it (it's genuinely the latest stable release),
but flag it clearly in the report — a major bump can be breaking (especially for providers)
and is worth the user reading release notes for before running `terraform init -upgrade` or `terraform plan`.

If the current constraint already covers the latest version and the numbers wouldn't change
(e.g. `~> 1.12` when the latest Terraform is `1.12.4` — no change to make since dropping the
patch gives the same string), leave the line untouched and note "already latest" in the report.

## 5. Apply the change

Edit only the version string(s) in place:

  - `required_version = "..."` inside the `terraform` block.
  - `version = "..."` inside each provider's block under `required_providers`.

Don't touch `source`, the registry-link comments above each provider
(`# https://registry.terraform.io/providers/<source>/latest`),
the header comments, block ordering, or formatting elsewhere in the file.
After editing, run `terraform fmt` on each changed file so indentation/alignment stays canonical.

## 6. Report

Finish with a table like:

| File | Item | Old constraint | New constraint | Notes |
|----|----|----|----|----|
| modules/github/repository/versions.tf | terraform | >= 1.12.2 | >= 1.15.9 | |
| modules/github/repository/versions.tf | github | >= 6.11.1 | >= 6.13.0 | |
| projects/github/versions.tf | terraform | ~> 1.12 | ~> 1.12 | already latest |
| projects/github/versions.tf | github | ~> 6.0 | ~> 7.0 | **major bump** — check provider changelog |

Then run `git diff` so the changes are visible, and stop.
Don't run `terraform init -upgrade`, commit, push, or open a PR unless the user explicitly asks for that next.
