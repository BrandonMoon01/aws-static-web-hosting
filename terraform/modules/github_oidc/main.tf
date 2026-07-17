terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
  }
}

data "aws_caller_identity" "current" {}

# Fetch the GitHub OIDC endpoint certificate so the provider thumbprint stays current.
data "tls_certificate" "github" {
  url = "https://token.actions.githubusercontent.com/.well-known/openid-configuration"
}

locals {
  account_id        = data.aws_caller_identity.current.account_id
  oidc_provider_arn = "arn:aws:iam::${local.account_id}:oidc-provider/token.actions.githubusercontent.com"
  role_arn          = "arn:aws:iam::${local.account_id}:role/${var.role_name}"
  policy_arn        = "arn:aws:iam::${local.account_id}:policy/${var.role_name}-policy"
  lock_table_arn    = "arn:aws:dynamodb:${var.region}:${local.account_id}:table/${var.lock_table_name}"
}

# Trust GitHub Actions as an OpenID Connect identity provider (no static AWS keys).
resource "aws_iam_openid_connect_provider" "github" {
  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.github.certificates[0].sha1_fingerprint]
}

# Role that GitHub Actions assumes, restricted to pushes on the main branch of this repo.
resource "aws_iam_role" "github_actions" {
  name = var.role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = aws_iam_openid_connect_provider.github.arn
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
            "token.actions.githubusercontent.com:sub" = "repo:${var.github_org}/${var.github_repo}:ref:refs/heads/main"
          }
        }
      }
    ]
  })
}

# Permissions scoped to only the services this project manages.
resource "aws_iam_policy" "github_actions" {
  name        = "${var.role_name}-policy"
  description = "Deploy permissions for the ${var.github_repo} static website pipeline"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "TerraformStateAndWebsiteBuckets"
        Effect = "Allow"
        Action = "s3:*"
        Resource = [
          "arn:aws:s3:::${var.state_bucket_name}",
          "arn:aws:s3:::${var.state_bucket_name}/*",
          "arn:aws:s3:::${var.website_bucket_name}",
          "arn:aws:s3:::${var.website_bucket_name}/*"
        ]
      },
      {
        Sid      = "TerraformStateLocking"
        Effect   = "Allow"
        Action   = "dynamodb:*"
        Resource = local.lock_table_arn
      },
      {
        # CloudFront, ACM, and Route 53 offer limited resource-level scoping,
        # so these are granted at the service level.
        Sid    = "ContentDeliveryAndDns"
        Effect = "Allow"
        Action = [
          "cloudfront:*",
          "acm:*",
          "route53:*"
        ]
        Resource = "*"
      },
      {
        # Allow the pipeline to manage only its own OIDC provider, role, and policy.
        Sid    = "SelfManagedIdentity"
        Effect = "Allow"
        Action = "iam:*"
        Resource = [
          local.oidc_provider_arn,
          local.role_arn,
          local.policy_arn
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "github_actions" {
  role       = aws_iam_role.github_actions.name
  policy_arn = aws_iam_policy.github_actions.arn
}
