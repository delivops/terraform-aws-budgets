# terraform-aws-budgets

This Terraform module provisions an AWS Budget.
AWS Budgets gives you the ability to set custom budgets that alert you when your costs or usage exceed (or are forecasted to exceed) your budgeted amount. This helps you avoid unexpected and expensive surprises in your AWS bills.

## Installation

To use this module, you need to have Terraform installed. You can find installation instructions on the Terraform website.

## Usage

The module will create an AWS Budget.
Use this module multiple times to create budgets with different configurations.

Include this repository as a module in your existing terraform code:

```hcl
################################################################################
# AWS Budget
################################################################################

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
      value = ["Amazon Simple Storage Service", "Amazon Elastic Compute Cloud - Compute", "AWS Lambda"]
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

<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->

## information

1. Time to create a cost-anomaly-detector is around 2 minutes.

## License

MIT
```
