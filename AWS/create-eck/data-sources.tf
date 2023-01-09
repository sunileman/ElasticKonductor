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

data "curl" "iscsi" {
  http_method = "GET"
  uri = "https://raw.githubusercontent.com/longhorn/longhorn/v1.4.0/deploy/prerequisite/longhorn-iscsi-installation.yaml"
}

data "kubectl_file_documents" "iscsi_doc" {
  content = data.curl.iscsi.response
}

