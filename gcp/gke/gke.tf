# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster
resource "google_container_cluster" "k8s" {
  name                     = lower(random_pet.name.id)
  location                 = var.region
  remove_default_node_pool = true
  initial_node_count       = 1
  network                  = google_compute_network.main.self_link
  subnetwork               = google_compute_subnetwork.private.self_link
  logging_service          = var.gke_logging_service
  monitoring_service       = var.gke_monitoring_service
  networking_mode          = var.gke_networking_mode

  min_master_version       = data.google_container_engine_versions.zone.latest_master_version

  
  release_channel {
    channel   = var.release_channel
  }

  # Optional, if you want multi-zonal cluster
  #node_locations = [var.region]
  node_locations = var.zones
 
  resource_labels = {
      "env" =  lower(random_pet.name.id),
      "org" = lower(var.tags["org"]),
      "division" = lower(var.tags["division"]),
      "project" = lower(var.tags["project"]),
      "team"    = lower(var.tags["team"])
  }


  addons_config {
    http_load_balancing {
      disabled = var.gke_http_load_balancing_disabled
    }
    horizontal_pod_autoscaling {
      disabled = var.gke_horizontal_pod_autoscaling
    }
  }


  ip_allocation_policy {
    cluster_secondary_range_name  = var.gke_cluster_secondary_range_name
    services_secondary_range_name = var.gke_services_secondary_range_name
  }

  private_cluster_config {
    enable_private_nodes    = var.gke_enable_private_nodes
    enable_private_endpoint = var.gke_enable_private_endpoint
    master_ipv4_cidr_block  = var.gke_master_ipv4_cidr_block
  }

}

