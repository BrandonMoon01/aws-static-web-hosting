variable "website_bucket" {
  description = "Name of the S3 bucket that hosts the website content"
  type        = string
}

variable "force_destroy" {
  description = "Whether to allow the bucket to be destroyed while it still contains objects"
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
