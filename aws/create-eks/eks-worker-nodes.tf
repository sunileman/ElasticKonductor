# EKS Node Groups

resource "aws_eks_node_group" "master" {
  cluster_name    = aws_eks_cluster.OneClick.name
  node_group_name = "master"
  node_role_arn   = aws_iam_role.node.arn
  subnet_ids      = flatten([aws_subnet.private[*].id]) 

  scaling_config {
    desired_size = var.master_instance_count
    max_size     = var.master_instance_count + 1
    min_size     = var.master_instance_count
  }


  ami_type       = var.master_ami_type
  capacity_type  = var.master_capacity_type
  instance_types = var.master_instance_type
  disk_size      = var.master_ebs_volume

  tags = merge(
    var.tags,
    {env=random_pet.name.id}
  )

  labels = merge (
     {
       "aws.amazon.com/eks-local-ssd" = "true"
       eks-local-ssd = "true"
       "k8s.io/cluster-autoscaler/${aws_eks_cluster.OneClick.name}" = "owned"
       "k8s.io/cluster-autoscaler/enabled" = "true"
     },
     var.master_instance_k8s_label
  )

  depends_on = [
    aws_iam_role_policy_attachment.node_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node_AmazonEC2ContainerRegistryReadOnly,
    aws_nat_gateway.main
  ]
}

resource "aws_eks_node_group" "kibana" {
  cluster_name    = aws_eks_cluster.OneClick.name
  node_group_name = "kibana"
  node_role_arn   = aws_iam_role.node.arn
  subnet_ids      = flatten([aws_subnet.public[*].id])

  scaling_config {
    desired_size = var.kibana_instance_count
    max_size     = var.kibana_instance_count + 1
    min_size     = var.kibana_instance_count
  }


  ami_type       = var.kibana_ami_type
  capacity_type  = var.kibana_capacity_type
  instance_types = var.kibana_instance_type
  disk_size      = var.master_ebs_volume

  tags = merge(
    var.tags,
    {env=random_pet.name.id}
  )

  labels = merge (
     {
       "aws.amazon.com/eks-local-ssd" = "true"
       eks-local-ssd = "true"
       "k8s.io/cluster-autoscaler/${aws_eks_cluster.OneClick.name}" = "owned"
       "k8s.io/cluster-autoscaler/enabled" = "true"
     },
     var.kibana_instance_k8s_label
  )

  depends_on = [
    aws_iam_role_policy_attachment.node_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node_AmazonEC2ContainerRegistryReadOnly,
    aws_nat_gateway.main
  ]
}

resource "aws_eks_node_group" "hot" {
  cluster_name    = aws_eks_cluster.OneClick.name
  node_group_name = "hot"
  node_role_arn   = aws_iam_role.node.arn
  subnet_ids      = flatten([aws_subnet.private[*].id])
  scaling_config {
    desired_size = var.hot_instance_count
    max_size     = var.hot_instance_count + 1
    min_size     = var.hot_instance_count
  }


  ami_type       = var.hot_ami_type
  capacity_type  = var.hot_capacity_type
  instance_types = var.hot_instance_type
  disk_size      = var.master_ebs_volume

  tags = merge(
    var.tags,
    {env=random_pet.name.id}
  )

  labels = merge (
     {
       "aws.amazon.com/eks-local-ssd" = "true"
       eks-local-ssd = "true"
       "k8s.io/cluster-autoscaler/${aws_eks_cluster.OneClick.name}" = "owned"
       "k8s.io/cluster-autoscaler/enabled" = "true"
     },
     var.hot_instance_k8s_label
  )

  depends_on = [
    aws_iam_role_policy_attachment.node_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node_AmazonEC2ContainerRegistryReadOnly,
    aws_nat_gateway.main
  ]
}

resource "aws_eks_node_group" "warm" {
  cluster_name    = aws_eks_cluster.OneClick.name
  node_group_name = "warm"
  node_role_arn   = aws_iam_role.node.arn
  subnet_ids      = flatten([aws_subnet.private[*].id])
  scaling_config {
    desired_size = var.warm_instance_count
    max_size     = var.warm_instance_count + 1
    min_size     = var.warm_instance_count
  }


  ami_type       = var.warm_ami_type
  capacity_type  = var.warm_capacity_type
  instance_types = var.warm_instance_type
  disk_size      = var.master_ebs_volume

  tags = merge(
    var.tags,
    {env=random_pet.name.id}
  )

  labels = merge (
     {
       "aws.amazon.com/eks-local-ssd" = "true"
       eks-local-ssd = "true"
       "k8s.io/cluster-autoscaler/${aws_eks_cluster.OneClick.name}" = "owned"
       "k8s.io/cluster-autoscaler/enabled" = "true"
     },
     var.warm_instance_k8s_label
  )

  depends_on = [
    aws_iam_role_policy_attachment.node_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node_AmazonEC2ContainerRegistryReadOnly,
    aws_nat_gateway.main
  ]
}

resource "aws_eks_node_group" "cold" {
  cluster_name    = aws_eks_cluster.OneClick.name
  node_group_name = "cold"
  node_role_arn   = aws_iam_role.node.arn
  subnet_ids      = flatten([aws_subnet.private[*].id]) 
  scaling_config {
    desired_size = var.cold_instance_count
    max_size     = var.cold_instance_count + 1
    min_size     = var.cold_instance_count
  }


  ami_type       = var.cold_ami_type
  capacity_type  = var.cold_capacity_type
  instance_types = var.cold_instance_type
  disk_size      = var.master_ebs_volume

  tags = merge(
    var.tags,
    {env=random_pet.name.id}
  )

  labels = merge (
     {
       "aws.amazon.com/eks-local-ssd" = "true"
       eks-local-ssd = "true"
       "k8s.io/cluster-autoscaler/${aws_eks_cluster.OneClick.name}" = "owned"
       "k8s.io/cluster-autoscaler/enabled" = "true"
     },
     var.cold_instance_k8s_label
  )

  depends_on = [
    aws_iam_role_policy_attachment.node_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node_AmazonEC2ContainerRegistryReadOnly,
    aws_nat_gateway.main
  ]
}

resource "aws_eks_node_group" "frozen" {
  cluster_name    = aws_eks_cluster.OneClick.name
  node_group_name = "frozen"
  node_role_arn   = aws_iam_role.node.arn
  subnet_ids      = flatten([aws_subnet.private[*].id])
  scaling_config {
    desired_size = var.frozen_instance_count
    max_size     = var.frozen_instance_count + 1
    min_size     = var.frozen_instance_count
  }


  ami_type       = var.frozen_ami_type
  capacity_type  = var.frozen_capacity_type
  instance_types = var.frozen_instance_type
  disk_size      = var.master_ebs_volume

  tags = merge(
    var.tags,
    {env=random_pet.name.id}
  )

  labels = merge (
     {
       "aws.amazon.com/eks-local-ssd" = "true"
       eks-local-ssd = "true"
       "k8s.io/cluster-autoscaler/${aws_eks_cluster.OneClick.name}" = "owned"
       "k8s.io/cluster-autoscaler/enabled" = "true"
     },
     var.frozen_instance_k8s_label
  )

  depends_on = [
    aws_iam_role_policy_attachment.node_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node_AmazonEC2ContainerRegistryReadOnly,
    aws_nat_gateway.main
  ]
}

resource "aws_eks_node_group" "ml" {
  cluster_name    = aws_eks_cluster.OneClick.name
  node_group_name = "ml"
  node_role_arn   = aws_iam_role.node.arn
  subnet_ids      = flatten([aws_subnet.private[*].id])
  scaling_config {
    desired_size = var.ml_instance_count
    max_size     = var.ml_instance_count + 1
    min_size     = var.ml_instance_count
  }


  ami_type       = var.ml_ami_type
  capacity_type  = var.ml_capacity_type
  instance_types = var.ml_instance_type
  disk_size      = var.master_ebs_volume

  tags = merge(
    var.tags,
    {env=random_pet.name.id}
  )

  labels = merge (
     {
       "aws.amazon.com/eks-local-ssd" = "true"
       eks-local-ssd = "true"
       "k8s.io/cluster-autoscaler/${aws_eks_cluster.OneClick.name}" = "owned"
       "k8s.io/cluster-autoscaler/enabled" = "true"
     },
     var.ml_instance_k8s_label
  )

  depends_on = [
    aws_iam_role_policy_attachment.node_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node_AmazonEC2ContainerRegistryReadOnly,
    aws_nat_gateway.main
  ]
}

resource "aws_eks_node_group" "util" {
  cluster_name    = aws_eks_cluster.OneClick.name
  node_group_name = "util"
  node_role_arn   = aws_iam_role.node.arn
  subnet_ids      = flatten([aws_subnet.public[*].id])
  scaling_config {
    desired_size = var.util_instance_count
    max_size     = var.util_instance_count + 1
    min_size     = var.util_instance_count
  }


  ami_type       = var.util_ami_type
  capacity_type  = var.util_capacity_type
  instance_types = var.util_instance_type
  disk_size      = var.master_ebs_volume

  tags = merge(
    var.tags,
    {env=random_pet.name.id}
  )

  labels = merge (
     {
       "aws.amazon.com/eks-local-ssd" = "true"
       eks-local-ssd = "true"
       "k8s.io/cluster-autoscaler/${aws_eks_cluster.OneClick.name}" = "owned"
       "k8s.io/cluster-autoscaler/enabled" = "true"
     },
     var.util_instance_k8s_label
  )

  depends_on = [
    aws_iam_role_policy_attachment.node_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node_AmazonEC2ContainerRegistryReadOnly,
  ]
}

# EKS Node IAM Role
resource "aws_iam_role" "node" {
  name = "${local.project}-Worker-Role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "node_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.node.name
}

resource "aws_iam_role_policy_attachment" "node_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.node.name
}

resource "aws_iam_role_policy_attachment" "node_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.node.name
}

