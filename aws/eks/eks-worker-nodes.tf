# EKS Node Groups

resource "aws_eks_node_group" "master" {
  cluster_name    = aws_eks_cluster.OneClick.name
  count           = var.master_instance_count >= 1 ? 1 : 0

  node_group_name = "master"
  node_role_arn   = aws_iam_role.node.arn
  subnet_ids      = flatten([aws_subnet.private[*].id]) 

  scaling_config {
    desired_size = var.master_instance_count
    max_size     = var.master_max_instance_count
    min_size     = var.master_instance_count
  }


  ami_type       = var.master_ami_type
  capacity_type  = var.master_capacity_type
  instance_types = var.master_instance_type
  disk_size      =  200

  tags = merge(
    var.tags,
    {env=random_pet.name.id}
  )

  labels = merge(var.k8s_all_worker_labels, var.master_instance_k8s_label)

  depends_on = [
    aws_iam_role_policy_attachment.node_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node_AmazonEC2ContainerRegistryReadOnly,
    aws_nat_gateway.main
  ]
}

resource "aws_eks_node_group" "kibana" {
  cluster_name    = aws_eks_cluster.OneClick.name
  count           = var.kibana_instance_count >= 1 ? 1 : 0

  node_group_name = "kibana"
  node_role_arn   = aws_iam_role.node.arn
  subnet_ids      = flatten([aws_subnet.public[*].id])

  scaling_config {
    desired_size = var.kibana_instance_count
    max_size     = var.kibana_max_instance_count
    min_size     = var.kibana_instance_count
  }


  ami_type       = var.kibana_ami_type
  capacity_type  = var.kibana_capacity_type
  instance_types = var.kibana_instance_type
  disk_size      =  200

  tags = merge(
    var.tags,
    {env=random_pet.name.id}
  )

  labels = merge (var.k8s_all_worker_labels, var.kibana_instance_k8s_label)

  depends_on = [
    aws_iam_role_policy_attachment.node_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node_AmazonEC2ContainerRegistryReadOnly,
    aws_nat_gateway.main
  ]
}

resource "aws_eks_node_group" "hot" {
  cluster_name    = aws_eks_cluster.OneClick.name
  count           = var.hot_instance_count >= 1 ? 1 : 0

  node_group_name = "hot"
  node_role_arn   = aws_iam_role.node.arn
  subnet_ids      = flatten([aws_subnet.private[*].id])
  scaling_config {
    desired_size = var.hot_instance_count
    max_size     = var.hot_max_instance_count
    min_size     = var.hot_instance_count
  }


  ami_type       = var.hot_ami_type
  capacity_type  = var.hot_capacity_type
  instance_types = var.hot_instance_type
  disk_size      =  200

  tags = merge(
    var.tags,
    {env=random_pet.name.id}
  )

  labels = merge (var.k8s_all_worker_labels, var.hot_instance_k8s_label)

  depends_on = [
    aws_iam_role_policy_attachment.node_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node_AmazonEC2ContainerRegistryReadOnly,
    aws_nat_gateway.main
  ]
}

resource "aws_eks_node_group" "warm" {
  cluster_name    = aws_eks_cluster.OneClick.name
  count           = var.warm_instance_count >= 1 ? 1 : 0

  node_group_name = "warm"
  node_role_arn   = aws_iam_role.node.arn
  subnet_ids      = flatten([aws_subnet.private[*].id])
  scaling_config {
    desired_size = var.warm_instance_count
    max_size     = var.warm_max_instance_count
    min_size     = var.warm_instance_count
  }


  ami_type       = var.warm_ami_type
  capacity_type  = var.warm_capacity_type
  instance_types = var.warm_instance_type
  disk_size      =  200

  tags = merge(
    var.tags,
    {env=random_pet.name.id},
    {"k8s.io/cluster-autoscaler/node-template/label/nodetype"="warm"}
  )

  labels = merge (var.k8s_all_worker_labels, var.warm_instance_k8s_label)

  depends_on = [
    aws_iam_role_policy_attachment.node_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node_AmazonEC2ContainerRegistryReadOnly,
    aws_nat_gateway.main
  ]
}

resource "aws_eks_node_group" "cold" {
  cluster_name    = aws_eks_cluster.OneClick.name
  count           = var.cold_instance_count >= 1 ? 1 : 0

  node_group_name = "cold"
  node_role_arn   = aws_iam_role.node.arn
  subnet_ids      = flatten([aws_subnet.private[*].id]) 
  scaling_config {
    desired_size = var.cold_instance_count
    max_size     = var.cold_max_instance_count
    min_size     = var.cold_instance_count
  }


  ami_type       = var.cold_ami_type
  capacity_type  = var.cold_capacity_type
  instance_types = var.cold_instance_type
  disk_size      =  200

  tags = merge(
    var.tags,
    {env=random_pet.name.id}
  )

  labels = merge(var.k8s_all_worker_labels, var.cold_instance_k8s_label)

  depends_on = [
    aws_iam_role_policy_attachment.node_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node_AmazonEC2ContainerRegistryReadOnly,
    aws_nat_gateway.main
  ]
}

resource "aws_eks_node_group" "frozen" {
  cluster_name    = aws_eks_cluster.OneClick.name
  count           = var.frozen_instance_count >= 1 ? 1 : 0

  node_group_name = "frozen"
  node_role_arn   = aws_iam_role.node.arn
  subnet_ids      = flatten([aws_subnet.private[*].id])
  scaling_config {
    desired_size = var.frozen_instance_count
    max_size     = var.frozen_max_instance_count
    min_size     = var.frozen_instance_count
  }


  ami_type       = var.frozen_ami_type
  capacity_type  = var.frozen_capacity_type
  instance_types = var.frozen_instance_type
  disk_size      =  200

  tags = merge(
    var.tags,
    {env=random_pet.name.id}
  )

  labels = merge(var.k8s_all_worker_labels, var.frozen_instance_k8s_label)

  depends_on = [
    aws_iam_role_policy_attachment.node_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node_AmazonEC2ContainerRegistryReadOnly,
    aws_nat_gateway.main
  ]
}

resource "aws_eks_node_group" "ml" {
  cluster_name    = aws_eks_cluster.OneClick.name
  count           = var.ml_instance_count >= 1 ? 1 : 0

  node_group_name = "ml"
  node_role_arn   = aws_iam_role.node.arn
  subnet_ids      = flatten([aws_subnet.private[*].id])
  scaling_config {
    desired_size = var.ml_instance_count
    max_size     = var.ml_max_instance_count
    min_size     = var.ml_instance_count
  }


  ami_type       = var.ml_ami_type
  capacity_type  = var.ml_capacity_type
  instance_types = var.ml_instance_type
  disk_size      =  200

  tags = merge(
    var.tags,
    {env=random_pet.name.id}
  )

  labels = merge(var.k8s_all_worker_labels, var.ml_instance_k8s_label)

  depends_on = [
    aws_iam_role_policy_attachment.node_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node_AmazonEC2ContainerRegistryReadOnly,
    aws_nat_gateway.main
  ]
}

resource "aws_eks_node_group" "entsearch" {
  cluster_name    = aws_eks_cluster.OneClick.name
  count           = var.entsearch_instance_count >= 1 ? 1 : 0

  node_group_name = "entsearch"
  node_role_arn   = aws_iam_role.node.arn
  subnet_ids      = flatten([aws_subnet.private[*].id])
  scaling_config {
    desired_size = var.entsearch_instance_count
    max_size     = var.entsearch_max_instance_count
    min_size     = var.entsearch_instance_count
  }


  ami_type       = var.entsearch_ami_type
  capacity_type  = var.entsearch_capacity_type
  instance_types = var.entsearch_instance_type
  disk_size      =  200

  tags = merge(
    var.tags,
    {env=random_pet.name.id}
  )

  labels = merge(var.k8s_all_worker_labels, var.entsearch_instance_k8s_label)

  depends_on = [
    aws_iam_role_policy_attachment.node_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node_AmazonEC2ContainerRegistryReadOnly,
    aws_nat_gateway.main
  ]
}

resource "aws_eks_node_group" "otel" {
  cluster_name    = aws_eks_cluster.OneClick.name
  count           = var.otel_instance_count >= 1 ? 1 : 0

  node_group_name = "otel"
  node_role_arn   = aws_iam_role.node.arn
  subnet_ids      = flatten([aws_subnet.private[*].id])
  scaling_config {
    desired_size = var.otel_instance_count
    max_size     = var.otel_instance_count+1
    min_size     = var.otel_instance_count
  }


  ami_type       = var.otel_ami_type
  capacity_type  = var.otel_capacity_type
  instance_types = var.otel_instance_type
  disk_size      =  500

  tags = merge(
    var.tags,
    {env=random_pet.name.id}
  )

  labels = merge(var.k8s_all_worker_labels, var.otel_instance_k8s_label)

  depends_on = [
    aws_iam_role_policy_attachment.node_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node_AmazonEC2ContainerRegistryReadOnly,
    aws_nat_gateway.main
  ]
}

resource "aws_eks_node_group" "util" {
  cluster_name    = aws_eks_cluster.OneClick.name
  count           = var.util_instance_count >= 1 ? 1 : 0
  
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
  disk_size      =  200

  tags = merge(
    var.tags,
    {env=random_pet.name.id}
  )

  labels = merge(var.k8s_all_worker_labels, var.util_instance_k8s_label)

  depends_on = [
    aws_iam_role_policy_attachment.node_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node_AmazonEC2ContainerRegistryReadOnly,
  ]
}

# EKS Node IAM Role
resource "aws_iam_role" "node" {
  name = "${random_pet.name.id}-Worker-Role"

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

resource "aws_iam_role_policy_attachment" "node_AmazonEBSCSIDriverPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  role       = aws_iam_role.node.name
}

resource "aws_iam_role_policy_attachment" "node_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.node.name
}

resource "aws_iam_role_policy_attachment" "oneclick-workernodes-autoscale-policy" {
  role       = aws_iam_role.node.name
  policy_arn = aws_iam_policy.oneclick-autoscale-policy.arn
}


resource "aws_autoscaling_group_tag" "master_asg_tag" {
  count           = var.master_instance_count >= 1 ? 1 : 0
  autoscaling_group_name = aws_eks_node_group.master.resources[0].autoscaling_groups[0].name

  tag {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/nodetype"
    value               = "master"
    propagate_at_launch = false
  }
}


resource "aws_autoscaling_group_tag" "kibana_asg_tag" {
  count           = var.kiban_instance_count >= 1 ? 1 : 0
  autoscaling_group_name = aws_eks_node_group.kibana.resources[0].autoscaling_groups[0].name

  tag {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/nodetype"
    value               = "kibana"
    propagate_at_launch = false
  }
}


resource "aws_autoscaling_group_tag" "hot_asg_tag" {
  count                  = var.hot_instance_count >= 1 ? 1 : 0
  autoscaling_group_name = aws_eks_node_group.hot.resources[0].autoscaling_groups[0].name

  tag {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/nodetype"
    value               = "hot"
    propagate_at_launch = false
  }
}

resource "aws_autoscaling_group_tag" "warm_asg_tag" {
  count                  = var.warm_instance_count >= 1 ? 1 : 0
  autoscaling_group_name = aws_eks_node_group.warm.resources[0].autoscaling_groups[0].name

  tag {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/nodetype"
    value               = "warm"
    propagate_at_launch = false
  }
}


resource "aws_autoscaling_group_tag" "cold_asg_tag" {
  count                  = var.cold_instance_count >= 1 ? 1 : 0
  autoscaling_group_name = aws_eks_node_group.cold.resources[0].autoscaling_groups[0].name

  tag {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/nodetype"
    value               = "cold"
    propagate_at_launch = false
  }
}

resource "aws_autoscaling_group_tag" "frozen_asg_tag" {
  count                  = var.frozen_instance_count >= 1 ? 1 : 0
  autoscaling_group_name = aws_eks_node_group.frozen.resources[0].autoscaling_groups[0].name

  tag {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/nodetype"
    value               = "frozen"
    propagate_at_launch = false
  }
}


resource "aws_autoscaling_group_tag" "ml_asg_tag" {
  count                  = var.ml_instance_count >= 1 ? 1 : 0
  autoscaling_group_name = aws_eks_node_group.ml.resources[0].autoscaling_groups[0].name

  tag {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/nodetype"
    value               = "ml"
    propagate_at_launch = false
  }
}


resource "aws_autoscaling_group_tag" "util_asg_tag" {
  count                  = var.util_instance_count >= 1 ? 1 : 0
  autoscaling_group_name = aws_eks_node_group.util.resources[0].autoscaling_groups[0].name

  tag {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/nodetype"
    value               = "util"
    propagate_at_launch = false
  }
}


resource "aws_autoscaling_group_tag" "entsearch_asg_tag" {
  count                  = var.entsearch_instance_count >= 1 ? 1 : 0
  autoscaling_group_name = aws_eks_node_group.entsearch.resources[0].autoscaling_groups[0].name

  tag {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/nodetype"
    value               = "entsearch"
    propagate_at_launch = false
  }
}


resource "null_resource" "apply_master_ini_asg_tags" {
  count      = var.master_instance_count >= 1 ? 1 : 0
  depends_on = [aws_eks_node_group.master]

  provisioner "local-exec" {
    command = "python ini-add-tags.py ${aws_eks_node_group.master.resources[0].autoscaling_groups[0].name}"
  }
}


resource "null_resource" "apply_kibana_ini_asg_tags" {
  count      = var.kibana_instance_count >= 1 ? 1 : 0
  depends_on = [aws_eks_node_group.kibana]

  provisioner "local-exec" {
    command = "python ini-add-tags.py ${aws_eks_node_group.kibana.resources[0].autoscaling_groups[0].name}"
  }
}

resource "null_resource" "apply_hot_ini_asg_tags" {
  count      = var.hot_instance_count >= 1 ? 1 : 0
  depends_on = [aws_eks_node_group.hot]

  provisioner "local-exec" {
    command = "python ini-add-tags.py ${aws_eks_node_group.hot.resources[0].autoscaling_groups[0].name}"
  }
}


resource "null_resource" "apply_warm_ini_asg_tags" {
    count      = var.warm_instance_count >= 1 ? 1 : 0
  depends_on = [aws_eks_node_group.warm]

  provisioner "local-exec" {
    command = "python ini-add-tags.py ${aws_eks_node_group.warm.resources[0].autoscaling_groups[0].name}"
  }
}

resource "null_resource" "apply_cold_ini_asg_tags" {
  count      = var.cold_instance_count >= 1 ? 1 : 0
  depends_on = [aws_eks_node_group.cold]

  provisioner "local-exec" {
    command = "python ini-add-tags.py ${aws_eks_node_group.cold.resources[0].autoscaling_groups[0].name}"
  }
}

resource "null_resource" "apply_frozen_ini_asg_tags" {
  count      = var.frozen_instance_count >= 1 ? 1 : 0
  depends_on = [aws_eks_node_group.frozen]

  provisioner "local-exec" {
    command = "python ini-add-tags.py ${aws_eks_node_group.frozen.resources[0].autoscaling_groups[0].name}"
  }
}

resource "null_resource" "apply_ml_ini_asg_tags" {
  count      = var.ml_instance_count >= 1 ? 1 : 0
  depends_on = [aws_eks_node_group.ml]

  provisioner "local-exec" {
    command = "python ini-add-tags.py ${aws_eks_node_group.ml.resources[0].autoscaling_groups[0].name}"
  }
}

resource "null_resource" "apply_util_ini_asg_tags" {
  count      = var.util_instance_count >= 1 ? 1 : 0

  depends_on = [aws_eks_node_group.util]

  provisioner "local-exec" {
    command = "python ini-add-tags.py ${aws_eks_node_group.util.resources[0].autoscaling_groups[0].name}"
  }
}


resource "null_resource" "apply_entsearch_ini_asg_tags" {
  count      = var.entsearch_instance_count >= 1 ? 1 : 0

  depends_on = [aws_eks_node_group.entsearch]

  provisioner "local-exec" {
    command = "python ini-add-tags.py ${aws_eks_node_group.entsearch.resources[0].autoscaling_groups[0].name}"
  }
}