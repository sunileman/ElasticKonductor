output "lbname" {
  value = data.terraform_remote_state.namegen.outputs.lbname
}
output "lb2name" {
  value = data.terraform_remote_state.namegen.outputs.lb2name
}
output "region" {
  value = data.terraform_remote_state.k8s.outputs.region
}
output "clustername" {
  value = data.terraform_remote_state.k8s.outputs.cluster_name
}
