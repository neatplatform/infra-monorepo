## https://developer.hashicorp.com/terraform/language/values/variables
## https://developer.hashicorp.com/terraform/language/block/variable
## https://developer.hashicorp.com/terraform/language/expressions/type-constraints

variable "github_token" {
  description = "GitHub personal access token with appropriate permissions to manage the organization."
  type        = string
  sensitive   = true
}
