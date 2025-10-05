region = "us-east-2"

rds_instances = [
  {
    identifier         = "dev-app-mysql"
    cron_start         = "0 6 * * ? *"
    cron_stop          = "0 21 * * ? *"
    schedule_timezone  = "US/Eastern"
    state              = "ENABLED"
  },
  {
    identifier         = "test-users-db"
    cron_start         = "0 6 * * ? *"
    cron_stop          = "0 21 * * ? *"
    schedule_timezone  = "US/Eastern"
    state              = "ENABLED"
  }
]
