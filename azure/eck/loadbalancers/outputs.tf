
output "ingestLbName" {
  value = data.terraform_remote_state.namegen.outputs.ingestLbName
}
output "searchLbName" {
  value = data.terraform_remote_state.namegen.outputs.searchLbName
}
output "region" {
  value = data.terraform_remote_state.k8s.outputs.region
}
output "clustername" {
  value = data.terraform_remote_state.k8s.outputs.cluster_name
}
