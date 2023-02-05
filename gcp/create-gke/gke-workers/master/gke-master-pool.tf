# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_node_pool
resource "google_container_node_pool" "master" {
  name       = "master"
  cluster    = data.terraform_remote_state.k8s.outputs.gke_cluster_id
  version    = var.gke_version
 
  initial_node_count = var.master_initial_node_count_per_zone
  
  autoscaling {
    min_node_count = var.master_instance_count_per_zone
    max_node_count = var.master_max_instance_count_per_zone
  }
 

  upgrade_settings {
    max_surge = var.master_surge_count
  }


  node_config {
    preemptible  = false
    machine_type = var.master_instance_type
    image_type   = var.gke_image_type
    disk_size_gb = var.master_volume
    disk_type    = var.master_volume_type
   
    labels = var.master_instance_k8s_label 

    service_account = data.terraform_remote_state.k8s.outputs.gcp_service_account_email
    oauth_scopes = var.gke_oauth_scopes
  }
}