locals {
  domain_name = "$ROUTE53_DNS_DOMAIN"
}

module "zones" {
  source  = "terraform-aws-modules/route53/aws/modules/zones"
  version = "~> 2.3.0"

  zones = {
    "${local.domain_name}" = {
      comment = "${local.domain_name} ($ENVIRONMENT)"
      tags = {
        env = "$ENVIRONMENT"
      }
    }
  }

  tags = {
    ManagedBy = "Terraform"
  }
}

module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> 3.0"

  domain_name = local.domain_name
  zone_id     = module.zones.route53_zone_zone_id[local.domain_name]

  subject_alternative_names = [
    "*.${local.domain_name}",
  ]

  wait_for_validation = true

  tags = {
    Name = local.domain_name
  }
}
