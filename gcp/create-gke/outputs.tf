output "cluster_name" {
  value = google_container_cluster.k8s.name
}

output "region" {
  value = google_container_cluster.k8s.location
}
