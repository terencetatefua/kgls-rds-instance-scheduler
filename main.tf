locals {
  enable_lower_env = can(regex("^(dev|test|qa)-.*", var.identifier))
}

resource "aws_scheduler_schedule" "rds_stop" {
  count       = local.enable_lower_env ? 1 : 0
  name        = "rds-scheduler-${var.identifier}-stop"
  description = "Stops RDS instance or cluster on schedule"
  group_name  = "default"

  schedule_expression          = "cron(${var.cron_stop})"
  schedule_expression_timezone = var.schedule_timezone
  state                        = var.state

  flexible_time_window {
    mode = "OFF"
  }

  target {
    arn      = var.aurora_cluster ? "arn:aws:scheduler:::aws-sdk:rds:stopDBCluster" : "arn:aws:scheduler:::aws-sdk:rds:stopDBInstance"
    role_arn = aws_iam_role.event[0].arn
    input    = var.aurora_cluster ? jsonencode({ DbClusterIdentifier = var.identifier }) : jsonencode({ DbInstanceIdentifier = var.identifier })
  }
}

resource "aws_scheduler_schedule" "rds_start" {
  count       = local.enable_lower_env ? 1 : 0
  name        = "rds-scheduler-${var.identifier}-start"
  description = "Starts RDS instance or cluster on schedule"
  group_name  = "default"

  schedule_expression          = "cron(${var.cron_start})"
  schedule_expression_timezone = var.schedule_timezone
  state                        = var.state

  flexible_time_window {
    mode = "OFF"
  }

  target {
    arn      = var.aurora_cluster ? "arn:aws:scheduler:::aws-sdk:rds:startDBCluster" : "arn:aws:scheduler:::aws-sdk:rds:startDBInstance"
    role_arn = aws_iam_role.event[0].arn
    input    = var.aurora_cluster ? jsonencode({ DbClusterIdentifier = var.identifier }) : jsonencode({ DbInstanceIdentifier = var.identifier })
  }
}
