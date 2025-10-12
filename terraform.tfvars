
region = "us-east-2"
rds_instances = [
  {
    identifier         = "dev-app-mysql"
    cron_start         = "cron(10 18 * * ? *)" # 6:10 PM EST
    cron_stop          = "cron(00 18 * * ? *)" # 6:00 PM EST
    schedule_timezone  = "US/Eastern"
    state              = "ENABLED"
  },
  {
    identifier         = "test-users-db"
    cron_start         = "cron(10 18 * * ? *)"
    cron_stop          = "cron(00 18 * * ? *)"
    schedule_timezone  = "US/Eastern"
    state              = "ENABLED"
  }
]
