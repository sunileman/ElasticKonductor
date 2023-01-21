locals {
  project = "${var.project}-${var.tags["username"]}"
}

locals {
  master_pod_roles = ["master"]
  hot_pod_roles =  ["data_hot", "data_content", "ingest"]
  warm_pod_roles =  ["data_warm", "data_content"]
  cold_pod_roles =  ["data_cold" ]
  frozen_pod_roles =  ["data_frozen"]
  ml_pod_roles =  ["ml", "remote_cluster_client"]
}

