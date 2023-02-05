# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster
resource "google_container_cluster" "k8s" {
  name                     = lower(random_pet.name.id)
  location                 = var.region
  remove_default_node_pool = true
  initial_node_count       = 1
  network                  = google_compute_network.main.self_link
  subnetwork               = google_compute_subnetwork.private.self_link
  logging_service          = "logging.googleapis.com/kubernetes"
  monitoring_service       = "monitoring.googleapis.com/kubernetes"
  networking_mode          = "VPC_NATIVE"
  min_master_version       = var.gke_version
 

  release_channel {
    channel           = var.release_channel
  }

  # Optional, if you want multi-zonal cluster
  #node_locations = [var.region]
  node_locations = var.zones
 
  resource_labels = {
      "env" =  lower(random_pet.name.id),
      "owner" = lower(var.tags["Owner"]),
      "org" = lower(var.tags["Org"]),
      "division" = lower(var.tags["Division"]),
      "keepaliveuntil" = lower(var.tags["KeepAliveUntil"]),
      "project" = lower(var.tags["Project"])
  }


  addons_config {
    http_load_balancing {
      disabled = true
    }
    horizontal_pod_autoscaling {
      disabled = false
    }
  }


  ip_allocation_policy {
    cluster_secondary_range_name  = "k8s-pod-range"
    services_secondary_range_name = "k8s-service-range"
  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }

}

