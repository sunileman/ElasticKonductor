# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account
resource "google_service_account" "kubernetes" {
  account_id = lower(replace("${random_pet.name.id}", var.project, "oce"))
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_node_pool
resource "google_container_node_pool" "master" {
  name       = "master"
  cluster    = google_container_cluster.k8s.id
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

    service_account = google_service_account.kubernetes.email
    oauth_scopes = var.gke_oauth_scopes
  }
}


resource "google_container_node_pool" "kibana" {
  name    = "kibana"
  cluster = google_container_cluster.k8s.id
  version = var.gke_version



  node_count = var.kibana_instance_count


  node_config {
    preemptible  = true
    machine_type = var.kibana_instance_type
    image_type   = var.gke_image_type
    disk_size_gb = var.kibana_volume
    disk_type    = var.kibana_volume_type
    

    labels = var.kibana_instance_k8s_label

    service_account = google_service_account.kubernetes.email
    oauth_scopes = var.gke_oauth_scopes
  }
}


resource "google_container_node_pool" "hot" {
  name    = "hot"
  cluster = google_container_cluster.k8s.id
  version = var.gke_version

  management {
    auto_repair  = var.gke_auto_repair
    auto_upgrade = var.gke_auto_upgrade
  }

  initial_node_count = var.hot_initial_node_count_per_zone 

  autoscaling {
    min_node_count = var.hot_instance_count_per_zone
    max_node_count = var.hot_max_instance_count_per_zone
  }

  upgrade_settings {
    max_surge = var.hot_surge_count
  }

  node_config {
    preemptible  = true
    machine_type = var.hot_instance_type
    image_type   = var.gke_image_type
    disk_size_gb = var.hot_volume
    disk_type    = var.hot_volume_type
    
    labels = var.hot_instance_k8s_label

    service_account = google_service_account.kubernetes.email
    oauth_scopes = var.gke_oauth_scopes
  }
}

resource "google_container_node_pool" "warm" {
  name    = "warm"
  cluster = google_container_cluster.k8s.id
  version    = var.gke_version

  initial_node_count = var.warm_initial_node_count_per_zone 


  management {
    auto_repair  = var.gke_auto_repair
    auto_upgrade = var.gke_auto_upgrade
  }

  autoscaling {
    min_node_count = var.warm_instance_count_per_zone
    max_node_count = var.warm_max_instance_count_per_zone
  }

  upgrade_settings {
    max_surge = var.warm_surge_count
  }



  node_config {
    preemptible  = true
    machine_type = var.warm_instance_type
    image_type   = var.gke_image_type
    disk_size_gb = var.warm_volume
    disk_type    = var.warm_volume_type
    

    labels = var.warm_instance_k8s_label

    service_account = google_service_account.kubernetes.email
    oauth_scopes = var.gke_oauth_scopes
  }
}

resource "google_container_node_pool" "cold" {
  name    = "cold"
  cluster = google_container_cluster.k8s.id
  version    = var.gke_version

  initial_node_count = var.cold_initial_node_count_per_zone


  management {
    auto_repair  = var.gke_auto_repair
    auto_upgrade = var.gke_auto_upgrade
  }

  autoscaling {
    min_node_count = var.cold_instance_count_per_zone
    max_node_count = var.cold_max_instance_count_per_zone
  }

  upgrade_settings {
    max_surge = var.cold_surge_count
  }

  node_config {
    preemptible  = true
    machine_type = var.cold_instance_type
    image_type   = var.gke_image_type
    disk_size_gb = var.cold_volume
    disk_type    = var.cold_volume_type


    labels = var.cold_instance_k8s_label

    service_account = google_service_account.kubernetes.email
    oauth_scopes = var.gke_oauth_scopes
  }
}

resource "google_container_node_pool" "frozen" {
  name    = "frozen"
  cluster = google_container_cluster.k8s.id
  version    = var.gke_version

  initial_node_count = var.frozen_initial_node_count_per_zone

  management {
    auto_repair  = var.gke_auto_repair
    auto_upgrade = var.gke_auto_upgrade
  }

  autoscaling {
    min_node_count = var.frozen_instance_count_per_zone
    max_node_count = var.frozen_max_instance_count_per_zone
  }

  upgrade_settings {
    max_surge = var.frozen_surge_count
  }

  node_config {
    preemptible  = true
    machine_type = var.frozen_instance_type
    image_type   = var.gke_image_type
    disk_size_gb = var.frozen_volume
    disk_type    = var.frozen_volume_type


    labels = var.frozen_instance_k8s_label

    service_account = google_service_account.kubernetes.email
    oauth_scopes = var.gke_oauth_scopes
  }
}

resource "google_container_node_pool" "ml" {
  name    = "ml"
  cluster = google_container_cluster.k8s.id
  version    = var.gke_version

  initial_node_count = var.ml_initial_node_count_per_zone

  management {
    auto_repair  = var.gke_auto_repair
    auto_upgrade = var.gke_auto_upgrade
  }

  autoscaling {
    min_node_count = var.ml_instance_count_per_zone
    max_node_count = var.ml_max_instance_count_per_zone
  }

  upgrade_settings {
    max_surge = var.ml_surge_count
  }

  node_config {
    preemptible  = true
    machine_type = var.ml_instance_type
    image_type   = var.gke_image_type
    disk_size_gb = var.ml_volume
    disk_type    = var.ml_volume_type


    labels = var.ml_instance_k8s_label

    service_account = google_service_account.kubernetes.email
    oauth_scopes = var.gke_oauth_scopes
  }
}


resource "google_container_node_pool" "util" {
  name    = "util"
  cluster = google_container_cluster.k8s.id
  version    = var.gke_version


  node_count = var.util_instance_count
  node_locations = [var.zones[0]]

  management {
    auto_repair  = var.gke_auto_repair
    auto_upgrade = var.gke_auto_upgrade
  }

  node_config {
    preemptible  = true
    machine_type = var.util_instance_type
    image_type   = var.gke_image_type
    disk_size_gb = var.util_volume
    disk_type    = var.util_volume_type


    labels = var.util_instance_k8s_label

    service_account = google_service_account.kubernetes.email
    oauth_scopes = var.gke_oauth_scopes
  }
}

