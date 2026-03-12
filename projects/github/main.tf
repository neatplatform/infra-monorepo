# https://developer.hashicorp.com/terraform/language/block/terraform
terraform {
  # https://developer.hashicorp.com/terraform/language/backend/remote
  backend "remote" {}
}

# https://registry.terraform.io/providers/integrations/github/latest/docs
provider "github" {
  # The token can also be set via the GITHUB_TOKEN environment variable.
  # Alernatively, you can use a GitHub App to authenticate, which is more secure and recommended for production use.

  owner = local.github_org
  token = var.github_token
}
