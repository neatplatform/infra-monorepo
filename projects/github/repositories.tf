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
    "automation", "devops", "sre",
    "go", "javascript",
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
      context        = "Call / Validate"
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
    "automation", "devops", "sre",
    "monorepo", "github", "action", "workflow",
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
    "monorepo", "infra-as-code", "terraform",
    "github", "aws", "google-cloud", "azure", "kubernetes",
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

module "craft" {
  source = "../../modules/github/repository"

  name        = "craft"
  description = "A toolkit for building command-line applications in Go"
  visibility  = "public"
  archived    = false

  topics = [
    "go", "package", "cli", "terminal",
    "renovate",
  ]

  # Declare repository secrets.
  secrets = ["CODECOV_TOKEN"]

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
      context        = "Call / Lint",
      integration_id = 15368,
    },
    {
      context        = "Call / Test",
      integration_id = 15368,
    },
  ]
}

module "go-github" {
  source = "../../modules/github/repository"

  name        = "go-github"
  description = "The simple Go client for GitHub REST and GraphQL APIs"
  visibility  = "public"
  archived    = false

  topics = [
    "github", "api", "rest", "graphql",
    "go", "package", "client", "http",
    "renovate",
  ]

  # Declare repository secrets.
  secrets = ["CODECOV_TOKEN"]

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
  ]
}

module "changelog" {
  source = "../../modules/github/repository"

  name        = "changelog"
  description = "The simple changelog generator"
  visibility  = "public"
  archived    = false

  topics = [
    "changelog", "github", "markdown",
    "go", "app", "package", "cli", "terminal",
    "renovate",
  ]

  # Declare repository secrets.
  secrets = ["CODECOV_TOKEN"]

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
  ]
}

# Import a repository
import {
  to = module.go-github.github_repository.repo
  id = "go-github"
}

# Import a default branch
import {
  to = module.go-github.github_branch_default.default_branch
  id = "go-github"
}
