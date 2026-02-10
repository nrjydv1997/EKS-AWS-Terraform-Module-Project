locals {
  cluster_name = var.cluster_name
}

resource "aws_iam_role" "eks_oidc" {
  assume_role_policy = data.aws_iam_policy_document.eks_oidc_assume_role_policy.json
  name = "eks-oidc"
}

resource "aws_iam_policy" "eks-oidc-policy" {
  name = "test-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
        Effect = "Allow"
        Resource = "*"
        Action = [
            "s3:ListAllMyBuckets",
            "s3:GetBucketLocation",
            "*"
        ]
    }]
  })
}


resource "aws_iam_role_policy_attachment" "eks_oidc_attach" {
  role       = aws_iam_role.eks_oidc.name
  policy_arn = aws_iam_policy.eks-oidc-policy.arn
}

resource "aws_iam_role_policy_attachment" "alb-controller-policy-attach" {
  count      = var.is_alb_controller_enabled ? 1 : 0
  policy_arn = aws_iam_policy.alb_controller_policy.arn
  role       = aws_iam_role.alb_controller_role[count.index].name
}

#---Make contact between service account to OIDC provider---
data "aws_iam_policy_document" "eks_oidc_assume_role_policy" {
    statement {
      actions = ["sts:AssumeRoleWithWebIdentity"]
      effect = "Allow"

      condition {
        test = "StringEquals"
        variable = "${replace(var.oidc_provider_url, "https://", "")}:sub"
        values = ["system:serviceaccount:default:aws-test"]
      }

      principals {
        identifiers = [var.oidc_provider_arn]
        type = "Federated"
      }
    }
}