variable "region" {
  description = "AWS region for the provider and regional resources"
  type        = string
}

variable "github_org" {
  description = "GitHub organization or user that owns the repository"
  type        = string
}

variable "github_repo" {
  description = "Name of the GitHub repository allowed to assume the deploy role"
  type        = string
}

variable "github_actions_role_name" {
  description = "Name of the IAM role assumed by GitHub Actions via OIDC"
  type        = string
}

variable "bucket_name" {
  description = "Name of the S3 bucket that stores Terraform remote state"
  type        = string
}

variable "table_name" {
  description = "Name of the DynamoDB table used for Terraform state locking"
  type        = string
}

variable "root_domain" {
  description = "The root domain name for the website"
  type        = string
}

variable "dns_record_ttl" {
  description = "TTL (in seconds) for DNS validation records"
  type        = number
}

variable "website_bucket" {
  description = "Name of the S3 bucket that hosts the website content"
  type        = string
}

variable "force_destroy" {
  description = "Whether to allow the website bucket to be destroyed while it still contains objects"
  type        = bool
}

variable "versioning_enabled" {
  description = "Versioning status for the website bucket (Enabled, Disabled, or Suspended)"
  type        = string
}

variable "index_document" {
  description = "The index document served as the default root object"
  type        = string
}
