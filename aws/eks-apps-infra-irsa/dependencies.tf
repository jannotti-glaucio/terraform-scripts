data "aws_eks_cluster" "cluster" {
  name = local.eks_cluster_name
}
