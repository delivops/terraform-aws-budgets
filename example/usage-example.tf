module "example" {
  source       = "delivops/budgets/aws"
  version      = "0.0.1"
  budget_name  = "s3-api-calls-budget"
  budget_type  = "USAGE"
  limit_amount = 10000000  # 1m limit for API calls
  time_unit    = "DAILY"
  cost_filters = [
    {
      name  = "UsageTypeGroup"
      value = ["S3: API Requests - Standard"]
    }
  ]
  notifications = {
    api_calls_alert = {
      comparison_operator        = "GREATER_THAN"
      notification_type          = "ACTUAL"
      subscriber_email_addresses = ["osnat@delivops.com"]
      threshold                  = 80
      threshold_type             = "PERCENTAGE"
    },
  }
}
