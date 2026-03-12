## https://developer.hashicorp.com/terraform/language/values/variables
## https://developer.hashicorp.com/terraform/language/block/variable
## https://developer.hashicorp.com/terraform/language/expressions/type-constraints

variable "name" {
  description = "Name of the GitHub repository."
  type        = string
  nullable    = false
}

variable "description" {
  description = "Description of the GitHub repository."
  type        = string
  nullable    = true
  default     = null
}

variable "website" {
  description = "Website URL for the GitHub repository."
  type        = string
  nullable    = true
  default     = null
}

variable "visibility" {
  description = "Visibility of the GitHub repository: public or private."
  type        = string
  nullable    = false
  default     = "private"

  validation {
    condition     = var.visibility == "public" || var.visibility == "private"
    error_message = "visibility must be either public or private."
  }
}

variable "archived" {
  description = "Whether or not the GitHub repository is archived."
  type        = bool
  nullable    = false
  default     = false
}

variable "topics" {
  description = "List of topics for the GitHub repository."
  type        = list(string)
  nullable    = true
  default     = null
}

variable "labels" {
  description = "List of labels for the GitHub repository."
  type = list(object({
    name        = string
    color       = string
    description = optional(string)
  }))

  nullable = false
  default  = []
}

variable "merge_queue" {
  description = "Merge queue configuration. If null, the merge queue is disabled."
  type = object({
    merge_method                 = optional(string, "SQUASH")
    build_concurrency            = optional(number, 5)
    min_group_size               = optional(number, 1)
    max_group_size               = optional(number, 5)
    min_group_size_wait_minutes  = optional(number, 5)
    status_check_timeout_minutes = optional(number, 60)
  })

  nullable = true
  default  = null

  validation {
    condition     = var.merge_queue == null || contains(["MERGE", "SQUASH", "REBASE"], var.merge_queue.merge_method)
    error_message = "merge_method must be either MERGE, SQUASH, or REBASE."
  }

  validation {
    condition = var.merge_queue == null || (
      var.merge_queue.build_concurrency > 0 &&
      var.merge_queue.min_group_size > 0 &&
      var.merge_queue.max_group_size > 0 &&
      var.merge_queue.min_group_size <= var.merge_queue.max_group_size &&
      var.merge_queue.min_group_size_wait_minutes > 0 &&
      var.merge_queue.status_check_timeout_minutes > 0
    )
    error_message = "numeric values must be positive, and min_group_size must be less than or equal to max_group_size."
  }
}

variable "required_checks" {
  description = "List of required status checks for the pull requests targeting the default branch."
  type = list(object({
    context        = string
    integration_id = number
  }))

  nullable = true
  default  = null
}
