data "aws_eks_node_group" "master" {
  cluster_name    = local.project
  node_group_name = "master"
}
data "aws_eks_node_group" "hot" {
  cluster_name    = local.project
  node_group_name = "hot"
}
data "aws_eks_node_group" "warm" {
  cluster_name    = local.project
  node_group_name = "warm"
}
data "aws_eks_node_group" "cold" { 
  cluster_name    = local.project
  node_group_name = "cold"
}
data "aws_eks_node_group" "frozen" {
  cluster_name    = local.project
  node_group_name = "frozen"
}
data "aws_eks_node_group" "ml" {
  cluster_name    = local.project
  node_group_name = "ml"
}
