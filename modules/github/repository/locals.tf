## https://developer.hashicorp.com/terraform/language/values/locals

locals {
  default_branch = "main"
  default_labels = []

  merged_labels = merge(
    { for l in local.default_labels : l.name => l },
    { for l in var.labels : l.name => l }
  )
}
