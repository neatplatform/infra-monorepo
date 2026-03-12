## Reusable modules should set only their minimum allowed versions of Terraform and providers.
## https://developer.hashicorp.com/terraform/language/expressions/version-constraints

# https://developer.hashicorp.com/terraform/language/block/terraform
terraform {
  required_version = ">= 1.12.2"

  required_providers {
    # https://registry.terraform.io/providers/integrations/github/latest
    github = {
      source  = "integrations/github"
      version = ">= 6.11.1"
    }
  }
}
