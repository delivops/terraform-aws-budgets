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
    for_each = var.notifications
    content {
      comparison_operator        = notification.value.comparison_operator
      threshold                  = notification.value.threshold
      threshold_type             = notification.value.threshold_type
      notification_type          = notification.value.notification_type
      subscriber_email_addresses = distinct(concat(lookup(notification.value, "subscriber_email_addresses", []), var.extra_email_addresses))
    }
  }

  cost_types {
    include_credit             = lookup(var.cost_types, "include_credit", false)
    include_discount           = lookup(var.cost_types, "include_discount", true)
    include_other_subscription = lookup(var.cost_types, "include_other_subscription", true)
    include_recurring          = lookup(var.cost_types, "include_recurring", true)
    include_refund             = lookup(var.cost_types, "include_refund", false)
    include_support            = lookup(var.cost_types, "include_support", true)
    include_tax                = lookup(var.cost_types, "include_tax", true)
    include_upfront            = lookup(var.cost_types, "include_upfront", true)
    use_amortized              = lookup(var.cost_types, "use_amortized", false)
    use_blended                = lookup(var.cost_types, "use_blended", false)
  }
}
# resource "aws_budgets_budget_action" "budget_action" {
#   budget_name        = aws_budgets_budget.budget_alert.name
#   action_type        = "APPLY_IAM_POLICY"
#   approval_model     = "AUTOMATIC"
#   notification_type  = "ACTUAL"
#   execution_role_arn = aws_iam_role.example.arn

#   dynamic "action_threshold" {
#     for_each = var.notifications
#     content {
#       action_threshold_type  = notification.value.threshold_type
#       action_threshold_value = notification.value.threshold
#     }
#   }

#   definition {
#     iam_action_definition {
#       policy_arn = aws_iam_policy.example.arn
#       roles      = [aws_iam_role.example.name]
#     }
#   }

#   subscriber {
#     address           = "example@example.example"
#     subscription_type = "EMAIL"
#   }

#   tags = {
#     Tag1 = "Value1"
#     Tag2 = "Value2"
#   }
# }

# data "aws_iam_policy_document" "example" {
#   statement {
#     effect    = "Allow"
#     actions   = ["ec2:Describe*"]
#     resources = ["*"]
#   }
# }

# resource "aws_iam_policy" "example" {
#   name        = "example"
#   description = "My example policy"
#   policy      = data.aws_iam_policy_document.example.json
# }

# data "aws_partition" "current" {}

# data "aws_iam_policy_document" "assume_role" {
#   statement {
#     effect = "Allow"

#     principals {
#       type        = "Service"
#       identifiers = ["budgets.${data.aws_partition.current.dns_suffix}"]
#     }

#     actions = ["sts:AssumeRole"]
#   }
# }

# resource "aws_iam_role" "example" {
#   name               = "example"
#   assume_role_policy = data.aws_iam_policy_document.assume_role.json
# }

# resource "aws_budgets_budget" "example" {
#   name              = "example"
#   budget_type       = "USAGE"
#   limit_amount      = "10.0"
#   limit_unit        = "dollars"
#   time_period_start = "2006-01-02_15:04"
#   time_unit         = "MONTHLY"
# }
