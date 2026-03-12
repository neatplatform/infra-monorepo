# infra-monorepo

A mono repository for managing all infrastructure as code (IaC) across the organization.

## CI Checks

CI checks run on `pull_request` and `merge_queue` events, but only when the target branch is `main`.

**Why not on push to main?**

This repo uses merge queue, so all PRs land on `main` through the queue — running checks at that point would be redundant.

**Why not on other branches?**

Branches not targeting `main` skip CI checks entirely to reduce unnecessary runner usage.

## Tools

  - [Terraform](https://terraform.io)
  - [terraform-docs](https://terraform-docs.io)

## Resources
