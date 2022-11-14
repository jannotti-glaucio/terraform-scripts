data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

module "eks" {
  source = "terraform-aws-modules/eks/aws"
  version = "17.24.0"

  cluster_name    = "$EKS_CLUSTER"
  cluster_version = "1.21"
  subnets         = data.terraform_remote_state.vpc.outputs.vpc.private_subnets
  vpc_id          = data.terraform_remote_state.vpc.outputs.vpc.vpc_id

  write_kubeconfig = false
  enable_irsa      = true

  node_groups_defaults = {
    ami_type  = "AL2_x86_64"
    disk_size = 50
  }

  node_groups = {
    apps = {
      name_prefix      = "$EKS_CLUSTER-apps-worker-"
      desired_capacity = 3
      max_capacity     = 9
      min_capacity     = 3

      instance_types = ["m5.xlarge"]
      capacity_type  = "ON_DEMAND"

      k8s_labels = {
        Environment = "$ENVIRONMENT"
        Name        = "apps-worker"
      }

      additional_tags = {
        Name = "$EKS_CLUSTER-apps-worker"
      }
    }
  }

  map_roles = [
    {
      rolearn  = "arn:aws:iam::250135344706:role/Admin"
      username = "admins:{{SessionName}}"
      groups   = ["system:masters"]
    },
  ]

  tags = {
    Name = "$EKS_CLUSTER-eks"
  }
}
