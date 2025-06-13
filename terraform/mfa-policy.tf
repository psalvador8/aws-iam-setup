# MFA Required IAM Policy
resource "aws_iam_policy" "mfa_required_policy" {
  name        = "mfa-required-policy"
  description = "Deny all access unless MFA is enabled for the user"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid: "AllowListAndMFASetup",
        Effect: "Allow",
        Action: [
          "iam:ListUsers",
          "iam:ListVirtualMFADevices",
          "iam:CreateVirtualMFADevice",
          "iam:EnableMFADevice",
          "iam:ListMFADevices",
          "iam:ResyncMFADevice",
          "iam:GetUser"
        ],
        Resource: "*"
      },
      {
        Sid: "AllowManageOwnMFA",
        Effect: "Allow",
        Action: [
          "iam:DeactivateMFADevice"
        ],
        Resource: "arn:aws:iam::*:user/*",
        Condition: {
          Bool: {
            "aws:MultiFactorAuthPresent": "true"
          }
        }
      },
      {
        Sid: "DenyAllExceptWithMFA",
        Effect: "Deny",
        NotAction: [
          "iam:CreateVirtualMFADevice",
          "iam:EnableMFADevice",
          "iam:ListMFADevices",
          "iam:ListUsers",
          "iam:ListVirtualMFADevices",
          "iam:ResyncMFADevice",
          "iam:GetUser"
        ],
        Resource: "*",
        Condition: {
          BoolIfExists: {
            "aws:MultiFactorAuthPresent": "false"
          }
        }
      }
    ]
  })
}

# Explicitly attach MFA policy to each department group
resource "aws_iam_group_policy_attachment" "mfa_developers" {
  group      = aws_iam_group.developers.name
  policy_arn = aws_iam_policy.mfa_required_policy.arn
}

resource "aws_iam_group_policy_attachment" "mfa_operations" {
  group      = aws_iam_group.operations.name
  policy_arn = aws_iam_policy.mfa_required_policy.arn
}

resource "aws_iam_group_policy_attachment" "mfa_finance" {
  group      = aws_iam_group.finance.name
  policy_arn = aws_iam_policy.mfa_required_policy.arn
}

resource "aws_iam_group_policy_attachment" "mfa_analyst" {
  group      = aws_iam_group.analyst.name
  policy_arn = aws_iam_policy.mfa_required_policy.arn
}
