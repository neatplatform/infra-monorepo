# https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository
resource "github_repository" "repo" {
  name               = var.name
  description        = var.description
  homepage_url       = var.website
  visibility         = var.visibility
  topics             = var.topics
  archived           = var.archived
  archive_on_destroy = true

  # Features
  has_issues      = true
  has_wiki        = false
  has_discussions = false
  has_projects    = false

  # Pull Requests
  allow_merge_commit          = false
  allow_squash_merge          = true
  squash_merge_commit_title   = "COMMIT_OR_PR_TITLE"
  squash_merge_commit_message = "COMMIT_MESSAGES"
  allow_rebase_merge          = true
  allow_update_branch         = true
  allow_auto_merge            = false
  delete_branch_on_merge      = true

  # Security and Analysis
  # https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository#security-and-analysis-configuration
  dynamic "security_and_analysis" {
    for_each = var.visibility == "public" ? [1] : []

    content {
      # Advanced security is always available for public repos
      # advanced_security {
      #   status = "enabled"
      # }
      code_security {
        status = "enabled"
      }
      secret_scanning {
        status = "enabled"
      }
      secret_scanning_push_protection {
        status = "enabled"
      }
    }
  }
}

# https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch_default
resource "github_branch_default" "default_branch" {
  repository = github_repository.repo.name
  branch     = local.default_branch
}

# https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_ruleset
resource "github_repository_ruleset" "default_branch_protection" {
  repository  = github_repository.repo.name
  name        = "Protect default branch"
  target      = "branch"
  enforcement = "active"

  conditions {
    ref_name {
      include = ["~DEFAULT_BRANCH"]
      exclude = []
    }
  }

  rules {
    creation                = false
    update                  = false
    deletion                = true
    required_linear_history = true
    required_signatures     = true
    non_fast_forward        = true

    dynamic "merge_queue" {
      for_each = var.merge_queue == null ? [] : [1]

      content {
        grouping_strategy                 = "ALLGREEN" # or HEADGREEN
        merge_method                      = var.merge_queue.merge_method
        max_entries_to_build              = var.merge_queue.build_concurrency
        min_entries_to_merge              = var.merge_queue.min_group_size
        max_entries_to_merge              = var.merge_queue.max_group_size
        min_entries_to_merge_wait_minutes = var.merge_queue.min_group_size_wait_minutes
        check_response_timeout_minutes    = var.merge_queue.status_check_timeout_minutes
      }
    }

    pull_request {
      required_approving_review_count   = 0
      dismiss_stale_reviews_on_push     = true
      require_code_owner_review         = false
      require_last_push_approval        = false
      required_review_thread_resolution = true
      allowed_merge_methods             = ["squash", "rebase"]
    }

    dynamic "required_status_checks" {
      for_each = var.required_checks == null || length(var.required_checks) == 0 ? [] : [1]

      content {
        strict_required_status_checks_policy = true

        dynamic "required_check" {
          for_each = var.required_checks

          content {
            context        = required_check.value.context
            integration_id = required_check.value.integration_id
          }
        }
      }
    }
  }
}

# https://registry.terraform.io/providers/integrations/github/latest/docs/resources/issue_labels
resource "github_issue_label" "labels" {
  for_each = local.all_labels

  repository  = github_repository.repo.name
  name        = each.key
  color       = each.value.color
  description = each.value.description
}

# https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_secret
resource "github_actions_secret" "secrets" {
  for_each = toset(var.secrets)

  repository      = github_repository.repo.name
  secret_name     = each.value
  plaintext_value = "placeholder"

  # remote_updated_at is set by GitHub when the secret is updated via UI or API.
  # Ignoring it prevents Terraform from overriding the secret with an invalid value.
  lifecycle {
    ignore_changes = [remote_updated_at]
  }
}
