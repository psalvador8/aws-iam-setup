# AWS IAM Terraform Setup

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

