variable "index_document" {
  description = "The index document served as the default root object"
  type        = string
}

variable "root_domain" {
  description = "The root domain name for the website"
  type        = string
}

variable "bucket_regional_domain_name" {
  description = "The regional domain name of the S3 origin bucket"
  type        = string
}

variable "s3_bucket_id" {
  description = "The ID of the S3 origin bucket"
  type        = string
}

variable "ssl_cert_arn" {
  description = "The ARN of the validated ACM certificate"
  type        = string
}

variable "route53_zone_id" {
  description = "The ID of the Route 53 hosted zone"
  type        = string
}
