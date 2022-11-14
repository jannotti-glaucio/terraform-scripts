terraform {
  backend "s3" {
    bucket  = "terraform-state-$ENVIRONMENT"
    encrypt = true
    key     = "vpc/terraform.tfstate"
    region  = "$AWS_REGION"
  }
}
