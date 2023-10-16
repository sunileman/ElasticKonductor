locals {
  project = "${var.project}-${var.tags["username"]}"
}

locals {
  master_pod_roles = ["master", "remote_cluster_client"]
  hot_pod_roles =  ["data_hot", "data_content", "ingest", "remote_cluster_client"]
  warm_pod_roles =  ["data_warm", "data_content", "remote_cluster_client"]
  cold_pod_roles =  ["data_cold", "remote_cluster_client" ]
  frozen_pod_roles =  ["data_frozen", "remote_cluster_client"]
  ml_pod_roles =  ["ml", "remote_cluster_client"]
}

