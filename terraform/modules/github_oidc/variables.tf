variable "github_org" {
  description = "GitHub organization or user that owns the repository"
  type        = string
}

variable "github_repo" {
  description = "Name of the GitHub repository allowed to assume the deploy role"
  type        = string
}

variable "role_name" {
  description = "Name of the IAM role assumed by GitHub Actions"
  type        = string
}

variable "region" {
  description = "AWS region used to build regional resource ARNs (e.g. the lock table)"
  type        = string
}

variable "state_bucket_name" {
  description = "Name of the S3 bucket that stores Terraform remote state"
  type        = string
}

variable "website_bucket_name" {
  description = "Name of the S3 bucket that hosts the website content"
  type        = string
}

variable "lock_table_name" {
  description = "Name of the DynamoDB table used for Terraform state locking"
  type        = string
}
