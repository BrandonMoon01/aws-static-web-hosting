output "github_actions_role_arn" {
  description = "ARN of the IAM role GitHub Actions assumes to deploy (set as the AWS_ROLE_ARN secret)"
  value       = module.github_oidc.github_actions_role_arn
}

output "s3_bucket_id" {
  description = "The ID of the S3 bucket"
  value       = module.s3_website.s3_bucket_id
}

output "s3_bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = module.s3_website.s3_bucket_arn
}

output "website_url" {
  description = "The URL of the Website"
  value       = module.cloudfront.website_url
}

output "cloudfront_distribution_id" {
  description = "The ID of the CloudFront distribution"
  value       = module.cloudfront.cloudfront_distribution_id
}

output "cloudfront_distribution_arn" {
  description = "The ARN of the CloudFront distribution"
  value       = module.cloudfront.cloudfront_distribution_arn
}

output "cloudfront_domain_name" {
  description = "The domain name of the CloudFront distribution"
  value       = module.cloudfront.cloudfront_domain_name
}
