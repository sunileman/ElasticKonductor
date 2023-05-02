output "cluster_id" {
  value = ec_deployment.ess_cluster.id
}

output "ess_username" {
  value = ec_deployment.ess_cluster.elasticsearch_username 
}

output "ess_password" {
  value = ec_deployment.ess_cluster.elasticsearch_password
  sensitive = true
}