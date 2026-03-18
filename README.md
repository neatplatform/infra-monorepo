# infra-monorepo

A mono repository for managing all infrastructure as code (IaC) across the organization.

## Setup

### Tools

  - [Terraform](https://terraform.io)
  - [terraform-docs](https://terraform-docs.io)

### Access Tokens

The following tokens are required to run Terraform projects — both locally and in CI pipelines.

#### GitHub

Generate at: GitHub → Settings → Developer Settings → Personal Access Tokens → Fine-grained tokens

| **Scope** | **Permission** |
|----|----|
| Repository → Administration | Read & Write |
| Repository → Metadata | Read-only |
| Repository → Secrets | Read & Write|
| Organization → Administration |
| Read & Write |
| Organization → Members | Read & Write |
| Organization → Secrets| Read & Write |

#### HCP Terraform

Generate at: Terraform Cloud → Account Settings → Tokens

## CI Checks

CI checks run on `pull_request` and `merge_queue` events, but only when the target branch is `main`.

**Why not on push to main?**

This repo uses merge queue, so all PRs land on `main` through the queue — running checks at that point would be redundant.

**Why not on other branches?**

Branches not targeting `main` skip CI checks entirely to reduce unnecessary runner usage.

## Resources

  - **GitHub**
    - [Managing your personal access tokens](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens)
  - **HCP Terraform**
    - [Manage API tokens for HCP Terraform](https://developer.hashicorp.com/terraform/cloud-docs/users-teams-organizations/api-tokens)
