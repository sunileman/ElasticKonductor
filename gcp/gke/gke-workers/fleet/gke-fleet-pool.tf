resource "google_container_node_pool" "fleet" {
  
  name       = "fleet"

  #will create node pool if 1
  count = var.fleet_create_node_pool == true ? 1 : 0

  cluster = data.terraform_remote_state.k8s.outputs.gke_cluster_id
  version = "${data.google_container_engine_versions.zone.latest_node_version}"


  node_count = var.fleet_instance_count
  node_locations = [var.zones[0]]

  node_config {
    preemptible  = true
    machine_type = var.fleet_instance_type
    image_type   = var.gke_image_type
    disk_size_gb = var.fleet_volume
    disk_type    = var.fleet_volume_type

    local_nvme_ssd_block_config {
      local_ssd_count = var.fleet_local_ssd_count
    }

    labels = var.fleet_instance_k8s_label

    service_account = data.terraform_remote_state.k8s.outputs.gcp_service_account_email
    oauth_scopes = var.gke_oauth_scopes
  }
}
