output "clustername" {
  value = data.terraform_remote_state.k8s.outputs.cluster_name
}
output "region" {
  value = data.terraform_remote_state.k8s.outputs.region
}
output "fleet_pod" {
  value = var.fleet_pod_count
}
output "fleet_instance" {
  value = var.fleet_instance_count
}
