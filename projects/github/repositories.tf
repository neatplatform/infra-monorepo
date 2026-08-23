## https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository

module "github" {
  source = "../../modules/github/repository"

  name        = ".github"
  description = "Organization-wide default configs and files"
  visibility  = "public"
  archived    = false

  topics = [
    "github", "community", "template", "issue", "pull-request",
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

module "compose" {
  source = "../../modules/github/repository"

  name        = "compose"
  description = "A collection of Docker Compose files for local development and testing"
  visibility  = "public"
  archived    = false

  topics = [
    "compose", "docker", "podman", "container",
    "dev", "testing",
    "database", "observability", "telemetry",
    "logging", "metrics", "tracing",
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
    "go", "package", "client",
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

module "changelog" {
  source = "../../modules/github/repository"

  name        = "changelog"
  description = "The simple changelog generator"
  visibility  = "public"
  archived    = false

  topics = [
    "changelog", "github", "markdown",
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
    {
      context        = "Call / Build",
      integration_id = 15368,
    },
  ]
}

module "mint" {
  source = "../../modules/github/repository"

  name        = "mint"
  description = "🌱 Unopinionated libraries for building reliable services in Go"
  website     = "https://neatplatform.github.io/mint"
  visibility  = "public"
  archived    = false

  topics = [
    "mint",
    "go", "library",
    "automation", "devops", "sre",
    "config", "testing",
    "observability", "telemetry",
    "logging", "metrics", "tracing",
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

module "mint-cli" {
  source = "../../modules/github/repository"

  name        = "mint-cli"
  description = "The companion command-line tool for Mint 🌱"
  website     = "https://neatplatform.github.io/mint-cli"
  visibility  = "public"
  archived    = false

  topics = [
    "mint",
    "go", "cli", "terminal",
    "automation", "devops", "sre",
    "scaffolding", "build", "release",
    "changelog", "semantic-versioning",
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

module "mint-templates" {
  source = "../../modules/github/repository"

  name        = "mint-templates"
  description = "Scafoldding templates for the Mint CLI 🌱"
  website     = "https://neatplatform.github.io/mint-templates"
  visibility  = "public"
  archived    = false

  topics = [
    "mint",
    "templates", "scaffolding",
    "automation", "devops", "sre",
    "monorepo", "http", "grpc", "go",
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
