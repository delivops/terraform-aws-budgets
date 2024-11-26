variable "budget_name" {
  description = "The name of the budget. Unique within accounts."
  type        = string

}
variable "budget_type" {
  description = "Whether this budget tracks monetary cost or usage. Availiable options: 'COST', 'USAGE', 'SAVINGS_PLANS_UTILIZATION', 'RI_UTILIZATION'."
  type        = string
  default     = "COST"
}

variable "limit_amount" {
  description = "The amount of cost or usage being measured for a budget"
  type        = number
  default     = 100
}

variable "limit_unit" {
  description = "The unit of measurement used for the budget forecast, actual spend, or budget threshold."
  type        = string
  default     = "USD"
}

variable "time_period_start" {
  description = "The start of the time period covered by the budget. If you don't specify a start date, AWS defaults to the start of your chosen time period. The start date must come before the end date. Format: 2017-01-01_12:00"
  type        = string
  default     = null
}

variable "time_period_end" {
  description = "The end of the time period covered by the budget. There are no restrictions on the end date. Format: 2017-01-01_12:00"
  type        = string
  default     = null
}

variable "time_unit" {
  description = "The length of time until a budget resets the actual and forecasted spend. Valid values: MONTHLY, QUARTERLY, ANNUALLY, and DAILY."
  type        = string
  default     = "MONTHLY"
}

variable "cost_filters" {
  description = <<EOT
  A list of CostFilter name/values pair to apply to budget.
  Example:
  ```terraform
  [
    {
      name  = "AZ"
      value = ["eu-central-1b"]
    },
  ]
  EOT
  type = list(object({
    name  = string
    value = list(string)
  }))
  default = []
}

variable "email_addresses" {
  description = "A list of email addresses to notify if the budget exceeds the threshold."
  type        = list(string)
  default     = []
}

variable "sns_topic_arn" {
  type        = string
  description = "ARN of the SNS topic to send notifications to"
  default     = ""
}
