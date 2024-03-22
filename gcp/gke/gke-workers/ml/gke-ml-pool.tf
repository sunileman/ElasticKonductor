# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_node_pool
resource "google_container_node_pool" "ml" {
  count      = var.ml_initial_node_count_per_zone >= 1 ? 1 : 0
  
  name       = "ml"
  cluster    = data.terraform_remote_state.k8s.outputs.gke_cluster_id
  version = "${data.google_container_engine_versions.zone.latest_node_version}"
 
  initial_node_count = var.ml_initial_node_count_per_zone
  
  autoscaling {
    min_node_count = var.ml_instance_count_per_zone
    max_node_count = var.ml_max_instance_count_per_zone
  }
 

  upgrade_settings {
    max_surge = var.ml_surge_count
  }


  node_config {
    preemptible  = false
    machine_type = var.ml_instance_type
    image_type   = var.gke_image_type
    disk_size_gb = var.ml_volume
    disk_type    = var.ml_volume_type

    local_nvme_ssd_block_config {
      local_ssd_count = var.ml_local_ssd_count
    }

    labels = var.ml_instance_k8s_label 

    service_account = data.terraform_remote_state.k8s.outputs.gcp_service_account_email
    oauth_scopes = var.gke_oauth_scopes
  }
}