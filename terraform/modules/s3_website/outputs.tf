output "s3_bucket_id" {
  description = "The ID of the S3 bucket"
  value       = aws_s3_bucket.website_bucket.id
}

output "s3_bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = aws_s3_bucket.website_bucket.arn
}

output "index_document" {
  description = "The index document of the S3 website"
  value       = var.index_document
}

output "bucket_regional_domain_name" {
  description = "The regional domain name of the S3 bucket"
  value       = aws_s3_bucket.website_bucket.bucket_regional_domain_name
}