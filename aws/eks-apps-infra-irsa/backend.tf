terraform {
  backend "s3" {
    bucket  = "terraform-state-$ENVIRONMENT"
    encrypt = true
    key     = "eks-apps-infra-irsa/terraform.tfstate"
    region  = "$AWS_REGION"
  }
}
