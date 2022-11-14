output "role_arns" {
  value = {
    "${module.cluster_autoscaler.irsa.iam_role_name}"           = module.cluster_autoscaler.irsa.iam_role_arn
    "${module.external_dns.irsa.iam_role_name}"                 = module.external_dns.irsa.iam_role_arn
    "${module.aws_load_balancer_controller.irsa.iam_role_name}" = module.aws_load_balancer_controller.irsa.iam_role_arn
  }
}
