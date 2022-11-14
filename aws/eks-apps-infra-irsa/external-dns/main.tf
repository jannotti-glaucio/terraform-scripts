module "irsa" {
  source      = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version     = "~> 4.3.0"
  create_role = true

  role_name = "external-dns-${var.env}"

  provider_url = var.provider_url

  role_policy_arns = [
    aws_iam_policy.policy.arn
  ]

  oidc_fully_qualified_subjects = ["system:serviceaccount:kube-system:external-dns-"]

  tags = {
    Role = "role-with-oidc"
  }

}

resource "aws_iam_policy" "policy" {
  name        = "AllowExternalDNSUpdates-${var.env}"
  description = "Allow External DNS to update records"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "route53:ChangeResourceRecordSets"
        ],
        "Resource" : [
          "arn:aws:route53:::hostedzone/*"
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "route53:ListHostedZones",
          "route53:ListResourceRecordSets"
        ],
        "Resource" : [
          "*"
        ]
      }
    ]
  })
}
