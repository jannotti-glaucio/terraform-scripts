terraform {
  backend "s3" {
    bucket  = "terraform-state-$ENVIRONMENT"
    encrypt = true
    key     = "eks/terraform.tfstate"
    region  = "$AWS_REGION"
  }
}
