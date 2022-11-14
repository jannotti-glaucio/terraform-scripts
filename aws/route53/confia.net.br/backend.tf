terraform {
  backend "s3" {
    bucket  = "terraform-state-$ENVIRONMENT"
    encrypt = true
    key     = "route53/$ROUTE53_DNS_DOMAIN/terraform.tfstate"
    region  = "$AWS_REGION"
  }
}
