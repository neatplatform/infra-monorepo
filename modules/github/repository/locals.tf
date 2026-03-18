## https://developer.hashicorp.com/terraform/language/values/locals

locals {
  default_branch = "main"
  default_labels = {}

  all_labels = merge(local.default_labels, var.labels)
}
