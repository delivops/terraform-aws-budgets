resource "aws_budgets_budget" "this" {
  name              = var.budget_name
  budget_type       = var.budget_type
  limit_amount      = var.limit_amount
  limit_unit        = var.limit_unit
  time_period_start = var.time_period_start
  time_period_end   = var.time_period_end
  time_unit         = var.time_unit

  dynamic "cost_filter" {
    for_each = var.cost_filters
    content {
      name   = cost_filter.value.name
      values = cost_filter.value.value
    }
  }

  dynamic "notification" {
    for_each = local.notification_thresholds
    content {
      comparison_operator        = notification.value.comparison_operator
      threshold                  = notification.value.threshold
      threshold_type             = notification.value.threshold_type
      notification_type          = "FORECASTED"
      subscriber_email_addresses = local.subscriber_emails
      subscriber_sns_topic_arns  = [var.sns_topic_arn]
    }
  }

  cost_types {
    include_credit             = true
    include_discount           = true
    include_other_subscription = true
    include_recurring          = true
    include_refund             = true
    include_subscription       = true
    include_support            = true
    include_tax                = true
    include_upfront            = true
    use_blended                = true
  }
}
