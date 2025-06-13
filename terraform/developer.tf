# Developer Group
resource "aws_iam_group" "developers" {
    name = "developers"
}

# Developer User
resource "aws_iam_user" "developer1" {
    name = "developer1"
}


# Develper Group Membership
resource "aws_iam_user_group_membership" "developer_membership" {
    user = aws_iam_user.developer1.name
    groups = [aws_iam_group.developers.name]
}

# Developer Policy
resource "aws_iam_policy" "developer_policy" {
  name   = "developer-policy"
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "ec2:*",
          "s3:GetObject",
          "s3:PutObject",
          "logs:DescribeLogStreams",
          "logs:GetLogEvents"
        ]
        Resource = "*"
      }
    ]
  })
}

# Attach Developer Group Policy
resource "aws_iam_group_policy_attachment" "developer_attach" {
  group      = aws_iam_group.developers.name
  policy_arn = aws_iam_policy.developer_policy.arn
}