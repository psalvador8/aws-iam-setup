# Analyst Group
resource "aws_iam_group" "analyst" {
  name = "analyst"
}

# Analyst User
resource "aws_iam_user" "analyst1" {
  name = "analyst1"
}

# Analyst Membership
resource "aws_iam_user_group_membership" "analyst_membership1" {
  user   = aws_iam_user.analyst1.name
  groups = [aws_iam_group.analyst.name]
}

# Analyst Policy
resource "aws_iam_policy" "analyst_policy" {
  name   = "analyst-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "s3:GetObject",
          "s3:ListBucket",
          "rds:Describe*"
        ]
        Resource = "*"
      }
    ]
  })
}

# Attach Analyst Group Policy
resource "aws_iam_group_policy_attachment" "analyst_attach" {
  group      = aws_iam_group.analyst.name
  policy_arn = aws_iam_policy.analyst_policy.arn
}
