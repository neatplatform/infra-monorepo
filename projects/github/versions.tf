## Root modules should set both a lower and upper bound on versions for each provider.
## https://developer.hashicorp.com/terraform/language/expressions/version-constraints

# https://developer.hashicorp.com/terraform/language/block/terraform
terraform {
  required_version = "~> 1.12"

  required_providers {
    # https://registry.terraform.io/providers/integrations/github/latest
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}
