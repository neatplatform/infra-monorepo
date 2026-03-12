# GitHub

A [Terraform](https://terraform.io) project for managing GitHub organization settings and resources as infrastructure-as-code.

## Prerequisites

  - [Terraform](https://developer.hashicorp.com/terraform) >= `1.12`

## Quick Start

```bash
# Generate the backend and variable files, then fill them in
make remote.tfbackend terraform.tfvars

make init
terraform plan
terraform apply
```

## Importing Existing Resources

Before Terraform can manage a resource that already exists in GitHub,
it must be imported into the Terraform state. There are two ways to do this.

### Import Command

```bash
# Import an organization
terraform import 'github_organization_settings.settings' organization

# Import a member
terraform import 'github_membership.members["username"]' organization:username

# Import a repository
terraform import 'module.name.github_repository.repo' repo
```

### Import Block

```hcl
# Import an organization
import {
  to = github_organization_settings.settings
  id = local.github_org
}

# Import a member
import {
  to = github_membership.members["username"]
  id = "${local.github_org}:username"
}

# Import a repository
import {
  to = module.name.github_repository.repo
  id = "repo"
}
```

Then run terraform apply to bring the resource under Terraform management.
Once the import is complete, remove the import block — it is no longer needed.

> Note: You must persist the Terraform state to keep imported resources tracked across future runs.

## State Management

This project is configured to use a remote backend, which stores and retrieves state from a single source of truth.

> Note: Make sure the Terraform Cloud workspace's **Working Directory** is pointed at this project (`projects/github`); otherwise imports of modules will fail.

It enables:

  - **Collaboration** — Team members share the same state.
  - **Safety** — State is persisted, versioned, and auditable.
  - **Locking** — prevents concurrent apply runs from corrupting state.

## Resources

  - **Importing Resources**
    - [Terraform Import Block](https://developer.hashicorp.com/terraform/language/import)
    - [Terraform CLI Import Command](https://developer.hashicorp.com/terraform/cli/import)
  - **State Management**
    - [State Locking](https://developer.hashicorp.com/terraform/language/state/locking)
    - [Workspaces](https://developer.hashicorp.com/terraform/language/state/workspaces)
    - [Remote State](https://developer.hashicorp.com/terraform/language/state/remote)
    - [State Storage and Locking](https://developer.hashicorp.com/terraform/language/state/backends)
    - **Backend**
      - [Backend Block Configuration](https://developer.hashicorp.com/terraform/language/backend)
      - [Terraform Cloud](https://developer.hashicorp.com/terraform/language/settings/backends/remote)
      - [GCS](https://developer.hashicorp.com/terraform/language/backend/gcs)
      - [S3](https://developer.hashicorp.com/terraform/language/backend/s3)
