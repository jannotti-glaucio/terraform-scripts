module "cluster_autoscaler" {
  source = "./cluster-autoscaler"

  provider_url = data.aws_eks_cluster.cluster.identity[0].oidc[0].issuer
  env          = local.env
}

module "external_dns" {
  source = "./external-dns"

  provider_url = data.aws_eks_cluster.cluster.identity[0].oidc[0].issuer
  env          = local.env
}

module "aws_load_balancer_controller" {
  source = "./aws-load-balancer-controller"

  provider_url = data.aws_eks_cluster.cluster.identity[0].oidc[0].issuer
  env          = local.env
}
