variable "root_domain" {
  description = "The root domain name for the website"
  type        = string
}

variable "dns_record_ttl" {
  description = "TTL (in seconds) for DNS validation records"
  type        = number
}
