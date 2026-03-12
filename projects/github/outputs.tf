## https://developer.hashicorp.com/terraform/language/values/outputs
## https://developer.hashicorp.com/terraform/language/block/output
## https://developer.hashicorp.com/terraform/language/expressions/type-constraints

output "current_workspace_name" {
  description = "The name of the current Terraform workspace."
  value       = terraform.workspace
}
