output "hosted_zone" {
  value = module.zones
}

output "acm_certificate_arn" {
  value = module.acm.acm_certificate_arn
}
