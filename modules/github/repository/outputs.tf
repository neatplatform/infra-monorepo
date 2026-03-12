## https://developer.hashicorp.com/terraform/language/values/outputs
## https://developer.hashicorp.com/terraform/language/block/output
## https://developer.hashicorp.com/terraform/language/expressions/type-constraints

output "full_name" {
  description = "The repository name in the form organization/repository."
  value       = github_repository.repo.full_name
}
