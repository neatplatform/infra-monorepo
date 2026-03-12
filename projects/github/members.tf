# https://registry.terraform.io/providers/integrations/github/latest/docs/resources/membership
resource "github_membership" "members" {
  for_each = {
    "moorara" = "admin"
  }

  username = each.key
  role     = each.value
}
