resource "aws_iam_role" "scheduler" {
  for_each = {
    for rds in var.rds_instances : rds.identifier => rds
  }

  name = "rds-scheduler-${each.key}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "scheduler.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "scheduler_policy" {
  for_each = aws_iam_role.scheduler

  name = "rds-scheduler-policy-${each.key}"
  role = each.value.name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "rds:StartDBInstance",
          "rds:StopDBInstance",
          "rds:DescribeDBInstances"
        ],
        Resource = "*"
      }
    ]
  })
}
