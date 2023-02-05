resource "google_container_node_pool" "kibana" {
  name    = "kibana"
  cluster = data.terraform_remote_state.k8s.outputs.gke_cluster_id
  version = var.gke_version



  node_count = var.kibana_instance_count


  node_config {
    preemptible  = true
    machine_type = var.kibana_instance_type
    image_type   = var.gke_image_type
    disk_size_gb = var.kibana_volume
    disk_type    = var.kibana_volume_type
    

    labels = var.kibana_instance_k8s_label

    service_account = data.terraform_remote_state.k8s.outputs.gcp_service_account_email
    oauth_scopes = var.gke_oauth_scopes
  }
}
