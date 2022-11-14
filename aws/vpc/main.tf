module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "$AWS_VPC"
  cidr = "10.1.0.0/16"

  azs              = ["$AWS_REGIONa", "$AWS_REGIONb", "$AWS_REGIONc"]
  public_subnets   = ["10.1.0.0/23", "10.1.2.0/23", "10.1.4.0/23"]
  private_subnets  = ["10.1.8.0/21", "10.1.16.0/21", "10.1.24.0/21"]
  database_subnets = ["10.1.32.0/24", "10.1.33.0/24", "10.1.34.0/24"]

  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  enable_dns_hostnames = true

  public_subnet_tags = {
    "kubernetes.io/cluster/$EKS_CLUSTER" = "shared"
    "kubernetes.io/role/elb"            = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/$EKS_CLUSTER" = "shared"
    "kubernetes.io/role/internal-elb"   = "1"
  }

  tags = {
    Terraform   = "true"
    Environment = "$ENVIRONMENT"
  }
}
