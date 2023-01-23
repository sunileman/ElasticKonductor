# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account
resource "google_service_account" "kubernetes" {
  account_id = "oneclick"
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_node_pool
resource "google_container_node_pool" "master" {
  name       = "master"
  cluster    = google_container_cluster.k8s.id
  version    = var.gke_version
  
  autoscaling {
    min_node_count = var.master_instance_count
    max_node_count = var.master_max_instance_count
  }

  management {
    auto_repair  = true
    auto_upgrade = false
  }

  node_config {
    preemptible  = false
    machine_type = var.master_instance_type
    image_type   = "UBUNTU_CONTAINERD"
    disk_size_gb = var.master_volume
    disk_type = var.master_volume_type

    labels = {
      nodetype = "master"
    }

    service_account = google_service_account.kubernetes.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}

resource "google_container_node_pool" "kibana" {
  name    = "kibana"
  cluster = google_container_cluster.k8s.id
  version    = var.gke_version

  management {
    auto_repair  = true
    auto_upgrade = false
  }
 

  autoscaling {
    min_node_count = var.kibana_instance_count
    max_node_count = var.kibana_max_instance_count
  }


  node_config {
    preemptible  = true
    machine_type = var.kibana_instance_type
    image_type   = "UBUNTU_CONTAINERD"
    disk_size_gb = var.kibana_volume
    disk_type    = var.kibana_volume_type

    labels = {
      nodetype="kibana"
    }

    service_account = google_service_account.kubernetes.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}

resource "google_container_node_pool" "hot" {
  name    = "hot"
  cluster = google_container_cluster.k8s.id
  version = var.gke_version

  management {
    auto_repair  = true
    auto_upgrade = false
  }

  autoscaling {
    min_node_count = var.hot_instance_count
    max_node_count = var.hot_max_instance_count
  }

  node_config {
    preemptible  = true
    machine_type = var.hot_instance_type
    image_type   = "UBUNTU_CONTAINERD"
    disk_size_gb = var.hot_volume
    disk_type    = var.hot_volume_type

    labels = {
      nodetype="hot"
    }

    service_account = google_service_account.kubernetes.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}

resource "google_container_node_pool" "warm" {
  name    = "warm"
  cluster = google_container_cluster.k8s.id
  version    = var.gke_version

  management {
    auto_repair  = true
    auto_upgrade = false
  }
  
  autoscaling {
    min_node_count = var.warm_instance_count
    max_node_count = var.warm_max_instance_count
  }

  node_config {
    preemptible  = true
    machine_type = var.warm_instance_type
    image_type   = "UBUNTU_CONTAINERD"
    disk_size_gb = var.warm_volume
    disk_type    = var.warm_volume_type

    labels = {
      nodetype="warm"
    }

    service_account = google_service_account.kubernetes.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}

resource "google_container_node_pool" "cold" {
  name    = "cold"
  cluster = google_container_cluster.k8s.id
  version    = var.gke_version

  management {
    auto_repair  = true
    auto_upgrade = false
  }

  autoscaling {
    min_node_count = var.cold_instance_count
    max_node_count = var.cold_max_instance_count
  }

  node_config {
    preemptible  = true
    machine_type = var.cold_instance_type
    image_type   = "UBUNTU_CONTAINERD"
    disk_size_gb = var.cold_volume
    disk_type    = var.cold_volume_type

    labels = {
      nodetype="cold"
    }

    service_account = google_service_account.kubernetes.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}

resource "google_container_node_pool" "frozen" {
  name    = "frozen"
  cluster = google_container_cluster.k8s.id
  version    = var.gke_version
  management {
    auto_repair  = true
    auto_upgrade = false
  }

  autoscaling {
    min_node_count = var.frozen_instance_count
    max_node_count = var.frozen_max_instance_count
  }

  node_config {
    preemptible  = true
    machine_type = var.frozen_instance_type
    image_type   = "UBUNTU_CONTAINERD"
    disk_size_gb = var.frozen_volume
    disk_type    = var.frozen_volume_type

    labels = {
      nodetype="frozen"
    }

    service_account = google_service_account.kubernetes.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}

resource "google_container_node_pool" "ml" {
  name    = "ml"
  cluster = google_container_cluster.k8s.id
  version    = var.gke_version

  management {
    auto_repair  = true
    auto_upgrade = false
  }

  autoscaling {
    min_node_count = var.ml_instance_count
    max_node_count = var.ml_max_instance_count
  }

  node_config {
    preemptible  = true
    machine_type = var.ml_instance_type
    image_type   = "UBUNTU_CONTAINERD"
    disk_size_gb = var.ml_volume
    disk_type    = var.ml_volume_type

    labels = {
      nodetype="ml"
    }

    service_account = google_service_account.kubernetes.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}


resource "google_container_node_pool" "util" {
  name    = "util"
  cluster = google_container_cluster.k8s.id
  version    = var.gke_version

  management {
    auto_repair  = true
    auto_upgrade = false
  }


  autoscaling {
    total_min_node_count = 1
    total_max_node_count = 2
  }
  node_config {
    preemptible  = true
    machine_type = var.util_instance_type
    image_type   = "UBUNTU_CONTAINERD"
    disk_size_gb = var.util_volume
    disk_type    = var.util_volume_type

    labels = {
      nodetype="util"
    }

    service_account = google_service_account.kubernetes.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}

