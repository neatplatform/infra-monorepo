## https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository

module "github" {
  source = "../../modules/github/repository"

  name        = ".github"
  description = "Organization-wide default configs and files"
  visibility  = "public"
  archived    = false

  topics = [
    "github", "template",
  ]
}

module "renovate-config" {
  source = "../../modules/github/repository"

  name        = "renovate-config"
  description = "Shareable config presets for Renovate"
  visibility  = "public"
  archived    = false

  topics = [
    "renovate",
    "automation", "devops", "sre",
    "go", "javascript",
  ]

  # Enable merge queue with default settings.
  merge_queue = {}

  # Enable the required status checks.
  required_checks = [
    # FIXME: CodeQL does not run on merge queue triggers.
    # See https://github.com/github/codeql-action/issues/1537
    # {
    #   context        = "CodeQL",
    #   integration_id = 57789,
    # },
    {
      context        = "Analyze actions",
      integration_id = 15368,
    },
    {
      context        = "Config / Validate"
      integration_id = 15368
    },
  ]
}

module "actions" {
  source = "../../modules/github/repository"

  name        = "actions"
  description = "NeatPlatform GitHub Actions"
  visibility  = "public"
  archived    = false

  topics = [
    "github", "actions", "automation", "devops", "sre",
    "go", "javascript", "ruby", "bash", "terraform", "kubernetes",
    "renovate",
  ]

  # Enable merge queue with default settings.
  merge_queue = {}

  # Enable the required status checks.
  required_checks = [
    # FIXME: CodeQL does not run on merge queue triggers.
    # See https://github.com/github/codeql-action/issues/1537
    # {
    #   context        = "CodeQL",
    #   integration_id = 57789,
    # },
    {
      context        = "Analyze actions",
      integration_id = 15368,
    },
    {
      context        = "Analyze go",
      integration_id = 15368,
    },
    {
      context        = "Analyze ruby",
      integration_id = 15368,
    },
    {
      context        = "check-paths",
      integration_id = 15368,
    },
    {
      context        = "go-lint",
      integration_id = 15368,
    },
    {
      context        = "go-test",
      integration_id = 15368,
    },
    {
      context        = "k8s-lint",
      integration_id = 15368,
    },
    {
      context        = "ruby-lint",
      integration_id = 15368,
    },
    {
      context        = "shellcheck",
      integration_id = 15368,
    },
    {
      context        = "terraform",
      integration_id = 15368,
    },
  ]
}

module "infra-monorepo" {
  source = "../../modules/github/repository"

  name        = "infra-monorepo"
  description = "The single repository for all infrastructure-as-code"
  visibility  = "public"
  archived    = false

  topics = [
    "automation", "devops", "sre",
    "infra-as-code", "monorepo", "terraform", "kubernetes",
    "renovate",
  ]

  # Enable merge queue with default settings.
  merge_queue = {}

  # Enable the required status checks.
  required_checks = [
    # FIXME: CodeQL does not run on merge queue triggers.
    # See https://github.com/github/codeql-action/issues/1537
    # {
    #   context        = "CodeQL",
    #   integration_id = 57789,
    # },
    {
      context        = "Analyze actions",
      integration_id = 15368,
    },
  ]
}
