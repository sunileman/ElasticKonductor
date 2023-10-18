output "clustername" {
  value = data.terraform_remote_state.k8s.outputs.cluster_name
}
output "region" {
  value = data.terraform_remote_state.k8s.outputs.region
}
