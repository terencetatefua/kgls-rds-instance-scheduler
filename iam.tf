# Shared IAM Policy for RDS scheduler
resource "aws_iam_policy" "rds_scheduler_policy" {
  name        = "project-kgls-rds-scheduler-policy"
  path        = "/project/"
  description = "Policy for EventBridge Scheduler to manage RDS DB instances"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "rds:StartDBInstance",
          "rds:StopDBInstance",
          "rds:DescribeDBInstances"
        ],
        Resource = "*"
      }
    ]
  })
}

# Single IAM Role (shared across all schedules)
resource "aws_iam_role" "rds_scheduler_role" {
  name = "project-kgls-rds-scheduler-role"
  path = "/project/"

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

# Attach policy to role
resource "aws_iam_role_policy_attachment" "rds_scheduler_attach" {
  role       = aws_iam_role.rds_scheduler_role.name
  policy_arn = aws_iam_policy.rds_scheduler_policy.arn
}
