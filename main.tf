resource "aws_scheduler_schedule" "rds_start" {
  for_each = {
    for rds in var.rds_instances : rds.identifier => rds
  }

  name        = "rds-scheduler-${each.key}-start"
  group_name  = "default"
  description = "Start RDS DB ${each.key}"

  schedule_expression          = "cron(${each.value.cron_start})"
  schedule_expression_timezone = each.value.schedule_timezone
  state                        = each.value.state

  flexible_time_window {
    mode = "OFF"
  }

  target {
    arn      = "arn:aws:scheduler:::aws-sdk:rds:startDBInstance"
    role_arn = aws_iam_role.scheduler[each.key].arn
    input    = jsonencode({
      DbInstanceIdentifier = each.key
    })
  }
}

resource "aws_scheduler_schedule" "rds_stop" {
  for_each = {
    for rds in var.rds_instances : rds.identifier => rds
  }

  name        = "rds-scheduler-${each.key}-stop"
  group_name  = "default"
  description = "Stop RDS DB ${each.key}"

  schedule_expression          = "cron(${each.value.cron_stop})"
  schedule_expression_timezone = each.value.schedule_timezone
  state                        = each.value.state

  flexible_time_window {
    mode = "OFF"
  }

  target {
    arn      = "arn:aws:scheduler:::aws-sdk:rds:stopDBInstance"
    role_arn = aws_iam_role.scheduler[each.key].arn
    input    = jsonencode({
      DbInstanceIdentifier = each.key
    })
  }
}
