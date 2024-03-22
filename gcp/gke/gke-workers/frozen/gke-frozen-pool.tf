# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_node_pool
resource "google_container_node_pool" "frozen" {
  count           = var.frozen_initial_node_count_per_zone >= 1 ? 1 : 0
  
  name       = "frozen"
  cluster    = data.terraform_remote_state.k8s.outputs.gke_cluster_id
  version = "${data.google_container_engine_versions.zone.latest_node_version}"
 
  initial_node_count = var.frozen_initial_node_count_per_zone
  
  autoscaling {
    min_node_count = var.frozen_instance_count_per_zone
    max_node_count = var.frozen_max_instance_count_per_zone
  }
 

  upgrade_settings {
    max_surge = var.frozen_surge_count
  }


  node_config {
    preemptible  = false
    machine_type = var.frozen_instance_type
    image_type   = var.gke_image_type
    disk_size_gb = var.frozen_volume
    disk_type    = var.frozen_volume_type
   
    local_nvme_ssd_block_config {
      local_ssd_count = var.frozen_local_ssd_count
    }

    labels = var.frozen_instance_k8s_label 

    service_account = data.terraform_remote_state.k8s.outputs.gcp_service_account_email
    oauth_scopes = var.gke_oauth_scopes
  }
}