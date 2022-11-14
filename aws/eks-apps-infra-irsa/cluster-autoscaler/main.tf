module "irsa" {
  source      = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version     = "~> 4.3.0"
  create_role = true

  role_name = "cluster-autoscaler-${var.env}"

  provider_url = var.provider_url

  role_policy_arns = [
    aws_iam_policy.cluster_autoscaler.arn
  ]

  oidc_fully_qualified_subjects = ["system:serviceaccount:kube-system:cluster-autoscaler-${var.env}"]

  tags = {
    Role = "role-with-oidc"
  }

}

resource "aws_iam_policy" "cluster_autoscaler" {
  name        = "AmazonEKSClusterAutoscalerPolicy-${var.env}"
  description = "Allow Cluster Autoscaler to manage ASGs"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : [
          "autoscaling:DescribeAutoScalingGroups",
          "autoscaling:DescribeAutoScalingInstances",
          "autoscaling:DescribeLaunchConfigurations",
          "autoscaling:DescribeTags",
          "autoscaling:SetDesiredCapacity",
          "autoscaling:TerminateInstanceInAutoScalingGroup",
          "ec2:DescribeLaunchTemplateVersions"
        ],
        "Resource" : "*",
        "Effect" : "Allow"
      }
    ]
  })
}
