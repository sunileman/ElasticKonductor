# EKS Cluster
resource "aws_eks_cluster" "OneClick" {
  #name     = local.project
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
    var.tags
  )

  depends_on = [
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy
  ]
}


# EKS Cluster IAM Role
resource "aws_iam_role" "cluster" {
  #name = "${local.project}-Cluster-Role"
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


