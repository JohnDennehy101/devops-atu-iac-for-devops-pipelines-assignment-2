output "static_site_address" {
  value = aws_route53_record.static_site.fqdn
}
