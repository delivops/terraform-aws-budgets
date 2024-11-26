arn:aws:sns:eu-west-1:556196322339:tests

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

provider "aws" {
  region = "eu-west-1"
}

resource "aws_sns_topic" "sns_topic" {
  name         = "sns"
  display_name = "sns"
}

module "example" {
  source       = "delivops/budgets/aws"
  #version      = "0.0.4"

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
  sns_topic_arn   = aws_sns_topic.sns_topic.arn
  depends_on        = [aws_sns_topic.sns_topic]
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_budgets_budget.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/budgets_budget) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_budget_name"></a> [budget\_name](#input\_budget\_name) | The name of the budget. Unique within accounts. | `string` | n/a | yes |
| <a name="input_budget_type"></a> [budget\_type](#input\_budget\_type) | Whether this budget tracks monetary cost or usage. Availiable options: 'COST', 'USAGE', 'SAVINGS\_PLANS\_UTILIZATION', 'RI\_UTILIZATION'. | `string` | `"COST"` | no |
| <a name="input_cost_filters"></a> [cost\_filters](#input\_cost\_filters) | A list of CostFilter name/values pair to apply to budget.<br/>  Example:<pre>terraform<br/>  [<br/>    {<br/>      name  = "AZ"<br/>      value = ["eu-central-1b"]<br/>    },<br/>  ]</pre> | <pre>list(object({<br/>    name  = string<br/>    value = list(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_email_addresses"></a> [email\_addresses](#input\_email\_addresses) | A list of email addresses to notify if the budget exceeds the threshold. | `list(string)` | `[]` | no |
| <a name="input_limit_amount"></a> [limit\_amount](#input\_limit\_amount) | The amount of cost or usage being measured for a budget | `number` | `100` | no |
| <a name="input_limit_unit"></a> [limit\_unit](#input\_limit\_unit) | The unit of measurement used for the budget forecast, actual spend, or budget threshold. | `string` | `"USD"` | no |
| <a name="input_sns_topic_arn"></a> [sns\_topic\_arn](#input\_sns\_topic\_arn) | ARN of the SNS topic to send notifications to | `string` | `""` | no |
| <a name="input_time_period_end"></a> [time\_period\_end](#input\_time\_period\_end) | The end of the time period covered by the budget. There are no restrictions on the end date. Format: 2017-01-01\_12:00 | `string` | `null` | no |
| <a name="input_time_period_start"></a> [time\_period\_start](#input\_time\_period\_start) | The start of the time period covered by the budget. If you don't specify a start date, AWS defaults to the start of your chosen time period. The start date must come before the end date. Format: 2017-01-01\_12:00 | `string` | `null` | no |
| <a name="input_time_unit"></a> [time\_unit](#input\_time\_unit) | The length of time until a budget resets the actual and forecasted spend. Valid values: MONTHLY, QUARTERLY, ANNUALLY, and DAILY. | `string` | `"MONTHLY"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | ARN of the budget |
| <a name="output_budget_type"></a> [budget\_type](#output\_budget\_type) | Type of the budget |
| <a name="output_cost_filter"></a> [cost\_filter](#output\_cost\_filter) | A list of CostFilter name/values pair to apply to budget. |
| <a name="output_id"></a> [id](#output\_id) | ID of the budget |
| <a name="output_limit_amount"></a> [limit\_amount](#output\_limit\_amount) | The amount of cost or usage being measured for a budget. |
| <a name="output_name"></a> [name](#output\_name) | The name of a budget. Unique within accounts. |
| <a name="output_notification"></a> [notification](#output\_notification) | Object containing Budget Notifications. |
| <a name="output_time_period_end"></a> [time\_period\_end](#output\_time\_period\_end) | The end of the time period covered by the budget |
| <a name="output_time_period_start"></a> [time\_period\_start](#output\_time\_period\_start) | The start of the time period covered by the budget |
| <a name="output_time_unit"></a> [time\_unit](#output\_time\_unit) | The length of time until a budget resets the actual and forecasted spend. |
<!-- END_TF_DOCS -->

## information

1. Time to create a cost-anomaly-detector is around 2 minutes.

## License

MIT
