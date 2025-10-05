
# terraform-rds-eventbridge-scheduler

This Terraform module provisions **Amazon EventBridge Scheduler rules** to automatically **start and stop RDS or Aurora (MySQL-compatible) databases** on a fixed schedule.

It is designed to run **only on non-production environments**, such as `dev`, `test`, or `qa`, based on the RDS identifier naming pattern (e.g., `dev-app-db`, `test-user-db`, `qa-analytics-db`).

## Features

- ✅ Automatically **starts/stops RDS and Aurora** resources using scheduled rules
- ✅ Targets only **lower environments** using naming convention logic
- ✅ Supports both **RDS instances** and **Aurora MySQL clusters**
- ✅ Uses **EventBridge Scheduler** with direct AWS API calls
- ✅ No Lambda required
- ✅ Safe for use in shared accounts — **production databases will be ignored**

## Resources Created

The following AWS resources will be provisioned when the target matches the lower-environment naming pattern:

- **AWS EventBridge Scheduler Rule** (for RDS start)
- **AWS EventBridge Scheduler Rule** (for RDS stop)
- **IAM Role and Policy** for Scheduler to perform `rds:StartDB*` and `rds:StopDB*` actions

## Conditional Logic

The scheduler is **only enabled** for identifiers matching the following regular expression:

^(dev|test|qa)-.*
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.100.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.7.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.event](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.event_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_scheduler_schedule.rds_start](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/scheduler_schedule) | resource |
| [aws_scheduler_schedule.rds_stop](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/scheduler_schedule) | resource |
| [random_string.iam_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aurora_cluster"></a> [aurora\_cluster](#input\_aurora\_cluster) | Set to true if the identifier is an Aurora cluster | `bool` | `false` | no |
| <a name="input_cron_start"></a> [cron\_start](#input\_cron\_start) | Start schedule in cron format | `string` | n/a | yes |
| <a name="input_cron_stop"></a> [cron\_stop](#input\_cron\_stop) | Stop schedule in cron format | `string` | n/a | yes |
| <a name="input_identifier"></a> [identifier](#input\_identifier) | RDS DB instance or Aurora cluster identifier | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS region for deployment | `string` | n/a | yes |
| <a name="input_schedule_timezone"></a> [schedule\_timezone](#input\_schedule\_timezone) | Timezone for the schedule | `string` | `"US/Eastern"` | no |
| <a name="input_state"></a> [state](#input\_state) | Schedule state (ENABLED or DISABLED) | `string` | `"ENABLED"` | no |

## Outputs

No outputs.
