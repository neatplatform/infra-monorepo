# https://registry.terraform.io/providers/integrations/github/latest/docs/resources/organization_settings
resource "github_organization_settings" "settings" {
  billing_email = "moorara@gmail.com" # Private
  name          = "NeatPlatform"
  description   = ""
  email         = "" # Public
  blog          = "" # URL/Website
  company       = ""
  location      = ""
}

# https://registry.terraform.io/providers/integrations/github/latest/docs/resources/organization_ruleset

# https://registry.terraform.io/providers/integrations/github/latest/docs/resources/organization_webhook
