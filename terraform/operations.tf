# Operations Group
resource "aws_iam_group" "operations" {
    name = "operations"
}

# Operations User
resource "aws_iam_user" "operations1" {
    name = "operations1"
}

# Operations Group Membership
resource "aws_iam_user_group_membership" "operations_membership" {
    user = aws_iam_user.operations1.name
    groups = [aws_iam_group.operations.name]
}

# Operations Policy
resource "aws_iam_policy" "operations_policy" {
    name = "operations-policy"
    policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "ec2:*",
          "cloudwatch:*",
          "ssm:*",
          "rds:*"
        ]
        Resource = "*"
      }
    ]
  })
}

#Attach Group Policy
resource "aws_iam_group_policy_attachment" "operations_attach" {
    group = aws_iam_group.operations.name
    policy_arn = aws_iam_policy.operations_policy.arn
}