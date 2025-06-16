# AWS IAM Terraform Setup

Access Medum article [here](https://medium.com/@psalvador8/️-secure-iam-setup-on-aws-moving-beyond-the-root-account-in-startups-41b7534da869).

This Terraform project manages AWS IAM users, groups, policies, and MFA enforcement for multiple departments.


## Features

- Creates IAM groups and users for:
  - Developers
  - Operations
  - Finance
  - Analysts
- Attaches least-privilege policies to each group
- Enforces MFA for all users
- Applies strong password policy

## Prerequisites

- Terraform installed 
- AWS CLI configured with appropriate permissions
- Git installed (for version control)

