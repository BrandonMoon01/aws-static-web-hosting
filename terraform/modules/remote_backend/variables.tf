variable "bucket_name" {
  description = "Name of the S3 bucket that stores Terraform remote state"
  type        = string
}

variable "table_name" {
  description = "Name of the DynamoDB table used for Terraform state locking"
  type        = string
}
