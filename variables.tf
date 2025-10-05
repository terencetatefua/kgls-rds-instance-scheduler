variable "identifier" {
  description = "RDS DB instance or Aurora cluster identifier"
  type        = string
}

variable "aurora_cluster" {
  description = "Set to true if the identifier is an Aurora cluster"
  type        = bool
  default     = false
}

variable "cron_start" {
  description = "Start schedule in cron format"
  type        = string
}

variable "cron_stop" {
  description = "Stop schedule in cron format"
  type        = string
}

variable "schedule_timezone" {
  description = "Timezone for the schedule"
  type        = string
  default     = "US/Eastern"
}

variable "state" {
  description = "Schedule state (ENABLED or DISABLED)"
  type        = string
  default     = "ENABLED"
}

variable "region" {
  description = "AWS region for deployment"
  type        = string
}
