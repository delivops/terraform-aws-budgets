
module "example" {
  source       = "../"
  budget_name  = "123"
  budget_type  = "COST"
  limit_amount = 500
  cost_filters = [
    {
      name  = "Service"
      value = ["Amazon Simple Storage Service", "Amazon Elastic Compute Cloud - Compute", "AWS Lambda"]
    }
  ]
  email_addresses = ["osnat529@gmail.com", "yehu@gmail.com"]
  sns_topic_arn   = "arn:aws:sns:eu-west-1:xxxxxxxxx:tests"
}
