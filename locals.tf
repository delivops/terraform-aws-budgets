locals {
  notification_thresholds = [
    {
      threshold           = 100
      comparison_operator = "GREATER_THAN"
      threshold_type      = "PERCENTAGE"
    },
    {
      threshold           = 120
      comparison_operator = "GREATER_THAN"
      threshold_type      = "PERCENTAGE"
    },
    {
      threshold           = 150
      comparison_operator = "GREATER_THAN"
      threshold_type      = "PERCENTAGE"
    },
    {
      threshold           = 200
      comparison_operator = "GREATER_THAN"
      threshold_type      = "PERCENTAGE"
    }
  ]

  subscriber_emails         = distinct(concat(var.email_addresses))
  subscriber_sns_topic_arns = var.sns_topic_arn
}
