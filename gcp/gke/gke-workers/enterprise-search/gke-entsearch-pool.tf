resource "google_container_node_pool" "entsearch" {
  
  name       = "entsearch"
  count           = var.entsearch_instance_count >= 1 ? 1 : 0

  cluster = data.terraform_remote_state.k8s.outputs.gke_cluster_id
  version = "${data.google_container_engine_versions.zone.latest_node_version}"


  node_count = var.entsearch_instance_count

  ##remove node_locations if per zone instance is required
  node_locations = [var.zones[0]]


  node_config {
    preemptible  = true
    machine_type = var.entsearch_instance_type
    image_type   = var.gke_image_type
    disk_size_gb = var.entsearch_volume
    disk_type    = var.entsearch_volume_type
    
    local_nvme_ssd_block_config {
      local_ssd_count = var.entsearch_local_ssd_count
    }

    labels = var.entsearch_instance_k8s_label

    service_account = data.terraform_remote_state.k8s.outputs.gcp_service_account_email
    oauth_scopes = var.gke_oauth_scopes
  }
}