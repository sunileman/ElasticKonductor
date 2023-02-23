output "cluster_name" {
  value = aws_eks_cluster.OneClick.name
}

output "cluster_endpoint" {
  value = aws_eks_cluster.OneClick.endpoint
}

output "cluster_ca_certificate" {
  value = aws_eks_cluster.OneClick.certificate_authority[0].data
}

output "cluster_resources" {
  value = aws_eks_node_group.master.resources
}

output "master_autoscaling_group_name" {
  description = "master nodes autoscale group name"
  value = var.master_instance_count > 0 ? aws_eks_node_group.master.resources[0].autoscaling_groups[0].name : "NA"
}

output "hot_autoscaling_group_name" {
  description = "hot nodes autoscale group name"
  value = var.hot_instance_count > 0 ? aws_eks_node_group.hot.resources[0].autoscaling_groups[0].name : "NA"
}

output "warm_autoscaling_group_name" {
   description = "warm nodes autoscale group name"
   value = var.warm_instance_count > 0 ? aws_eks_node_group.warm.resources[0].autoscaling_groups[0].name : "NA"
}

output "cold_autoscaling_group_name" {
  description = "cold nodes autoscale group name"
  value = var.cold_instance_count > 0 ? aws_eks_node_group.cold.resources[0].autoscaling_groups[0].name : "NA"
}

output "frozen_autoscaling_group_name" {
  description = "frozen nodes autoscale group name"
  value = var.frozen_instance_count > 0 ? aws_eks_node_group.frozen.resources[0].autoscaling_groups[0].name : "NA"
}

output "ml_autoscaling_group_name" {
  description = "ml nodes autoscale group name"
  value = var.ml_instance_count > 0 ? aws_eks_node_group.ml.resources[0].autoscaling_groups[0].name : "NA"
}

output "region" {
  description = "AWS region"
  value       = var.region
}

