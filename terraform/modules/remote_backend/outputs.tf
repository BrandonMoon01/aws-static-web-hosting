output "state_bucket_arn" {
  description = "ARN of the Terraform remote state bucket"
  value       = aws_s3_bucket.terraform_state_bucket.arn
}

output "lock_table_arn" {
  description = "ARN of the Terraform state lock table"
  value       = aws_dynamodb_table.state_lock_table.arn
}
