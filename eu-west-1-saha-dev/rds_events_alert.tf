module "rds_alerts" {
  source                     = "git@github.com:Alizandieh/tf-modules.git//modules/RDS_events_alert?ref=fc0b0cc"
  db_event_subscription_name = "rds-event-alerts"
  sns_topic_name             = "rds-alerts"
  alert_email                = "ali.zandieh@gmail.com"
  source_type                = "db-instance"
  event_categories = [
    "availability",
    "deletion",
    "failure",
    "low storage",
    "read replica",
  ]
}
