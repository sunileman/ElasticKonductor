# EKS Cluster
resource "aws_eks_cluster" "OneClick" {
  name     = random_pet.name.id
  role_arn = aws_iam_role.cluster.arn
  version  = var.eks_version

  vpc_config {
    subnet_ids  = flatten([aws_subnet.public[*].id, aws_subnet.private[*].id])
    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access  = var.endpoint_public_access 
    public_access_cidrs     = var.client_access_cidr
  }

  tags = merge(
    var.tags,
    {env=random_pet.name.id}
  )

  depends_on = [
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy
  ]
}


# EKS Cluster IAM Role
resource "aws_iam_role" "cluster" {
  name = "${random_pet.name.id}-Cluster-Role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.cluster.name
}


resource "aws_iam_role_policy_attachment" "oneclick-autoscale-policy" {
  role       = aws_iam_role.cluster.name
  policy_arn = aws_iam_policy.oneclick-autoscale-policy.arn
}


resource "aws_iam_policy" "oneclick-autoscale-policy" {
  name        = "${random_pet.name.id}-autoscale-policy"
  path        = "/"
  description = "${random_pet.name.id} Autoscale Policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "autoscaling:DescribeAutoScalingGroups",
        "autoscaling:DescribeAutoScalingInstances",
        "autoscaling:DescribeLaunchConfigurations",
        "autoscaling:DescribeScalingActivities",
        "autoscaling:DescribeTags",
        "ec2:DescribeInstanceTypes",
        "ec2:DescribeLaunchTemplateVersions"
      ],
      "Resource": ["*"]
    },
    {
      "Effect": "Allow",
      "Action": [
        "autoscaling:SetDesiredCapacity",
        "autoscaling:TerminateInstanceInAutoScalingGroup",
        "ec2:DescribeImages",
        "ec2:GetInstanceTypesFromInstanceRequirements",
        "eks:DescribeNodegroup"
      ],
      "Resource": ["*"]
    }
  ]
  })
}


resource "aws_eks_addon" "ebs-csi-driver" {
  cluster_name = aws_eks_cluster.OneClick.name
  addon_name   = "aws-ebs-csi-driver"
}
