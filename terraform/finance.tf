# Finance Group
resource "aws_iam_group" "finance" {
  name = "finance"
}

# Finance User
resource "aws_iam_user" "finance1" {
  name = "finance1"
}

# Finance Group Membership
resource "aws_iam_user_group_membership" "finance_membership1" {
  user   = aws_iam_user.finance1.name
  groups = [aws_iam_group.finance.name]
}

# Finance Policy
resource "aws_iam_policy" "finance_policy" {
  name   = "finance-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "ce:*",              # Cost Explorer
          "budgets:*",         # AWS Budgets
          "ec2:Describe*",     # Read-only compute visibility
          "s3:ListBucket"
        ]
        Resource = "*"
      }
    ]
  })
}

# Attach Finacne Group Policy
resource "aws_iam_group_policy_attachment" "finance_attach" {
  group      = aws_iam_group.finance.name
  policy_arn = aws_iam_policy.finance_policy.arn
}
