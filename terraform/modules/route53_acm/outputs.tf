output "ssl_cert_arn" {
  description = "The ARN of the validated SSL Certificate"
  value       = aws_acm_certificate_validation.ssl_validation.certificate_arn
}

output "route53_zone_id" {
  description = "The ID of the Route 53 Zone"
  value       = data.aws_route53_zone.dns_zone.zone_id
}

output "root_domain" {
  description = "The root domain name for the website"
  value       = var.root_domain
}
