variable "region" {
  description = "AWS region"
  type        = string
}

variable "rds_instances" {
  description = "List of RDS DB instance scheduling configurations"
  type = list(object({
    identifier         = string
    cron_start         = string
    cron_stop          = string
    schedule_timezone  = string
    state              = string
  }))
}
