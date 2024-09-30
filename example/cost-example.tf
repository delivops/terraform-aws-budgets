
module "example" {
  source       = "delivops/budgets/aws"
  version      = "0.0.1"
  budget_name  = "123"
  budget_type  = "COST"
  limit_amount = 500
  time_unit    = "DAILY"
  cost_filters = [
    {
      name  = "Service"
      value = ["Amazon Simple Storage Service", "Amazon Elastic Compute Cloud - Compute","AWS Lambda"]
    }
  ]
  notifications = {
    test = {
      comparison_operator        = "GREATER_THAN"
      notification_type          = "ACTUAL"
      subscriber_email_addresses = ["osnat@delivops.com"]
      threshold                  = 80
      threshold_type             = "PERCENTAGE"
    },
  }
}
