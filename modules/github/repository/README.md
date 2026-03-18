## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.12.2 |
| <a name="requirement_github"></a> [github](#requirement\_github) | >= 6.11.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_github"></a> [github](#provider\_github) | >= 6.11.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [github_actions_secret.secrets](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_secret) | resource |
| [github_branch_default.default_branch](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch_default) | resource |
| [github_issue_label.labels](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/issue_label) | resource |
| [github_repository.repo](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository) | resource |
| [github_repository_ruleset.default_branch_protection](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_ruleset) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_archived"></a> [archived](#input\_archived) | Whether or not the GitHub repository is archived. | `bool` | `false` | no |
| <a name="input_description"></a> [description](#input\_description) | Description of the GitHub repository. | `string` | `null` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | List of labels for the GitHub repository. | <pre>map(object({<br/>    color       = string<br/>    description = optional(string)<br/>  }))</pre> | `{}` | no |
| <a name="input_merge_queue"></a> [merge\_queue](#input\_merge\_queue) | Merge queue configuration. If null, the merge queue is disabled. | <pre>object({<br/>    merge_method                 = optional(string, "SQUASH")<br/>    build_concurrency            = optional(number, 5)<br/>    min_group_size               = optional(number, 1)<br/>    max_group_size               = optional(number, 5)<br/>    min_group_size_wait_minutes  = optional(number, 5)<br/>    status_check_timeout_minutes = optional(number, 60)<br/>  })</pre> | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the GitHub repository. | `string` | n/a | yes |
| <a name="input_required_checks"></a> [required\_checks](#input\_required\_checks) | List of required status checks for the pull requests targeting the default branch. | <pre>list(object({<br/>    context        = string<br/>    integration_id = number<br/>  }))</pre> | `null` | no |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | List of labels for the GitHub repository. | `list(string)` | `[]` | no |
| <a name="input_topics"></a> [topics](#input\_topics) | List of topics for the GitHub repository. | `list(string)` | `null` | no |
| <a name="input_visibility"></a> [visibility](#input\_visibility) | Visibility of the GitHub repository: public or private. | `string` | `"private"` | no |
| <a name="input_website"></a> [website](#input\_website) | Website URL for the GitHub repository. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_full_name"></a> [full\_name](#output\_full\_name) | The repository name in the form organization/repository. |
