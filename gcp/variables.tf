variable "agent_count" {
  default = 3
}


variable "gcp_project" {
  description = "gcp project"
  type        = string
}

variable "region" {
  description = "region"
  default = "us-central1"
}


variable "zones" {
  description = "zones"
  default = ["us-central1-a", "us-central1-b", "us-central1-c"]
}


variable "gke_version" {
  description = "GKE Version"
  type        = string
  default     = "1.24.8-gke.401"
}

variable "release_channel" {
  description = "GKE Release Channel"
  type = string
  default = "STABLE"
}


variable "gke_auto_upgrade" {
  description = "auto upgrade"
  default = true
}

variable "gke_auto_repair" {
  description = "auto repair"
  default = false
}


variable "gke_image_type" {
  description = "gke container image type"
  type        = string
  default     = "UBUNTU_CONTAINERD"
}


variable "gke_oauth_scopes" {
  description = "gke oauth scopes"
  type        = list(string)
  default     = ["https://www.googleapis.com/auth/cloud-platform"]
}

variable "eck_version" {
  description = "ECK Version"
  type        = string
  default = "2.6.1"
}


variable "project" {
  description = "ClickDeployment Name"
  type = string
  default = "oneClickECK"
}


variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default = {
    "Project"     = "1ClickECK"
    "Environment" = "Development"
    "Owner"       = "someone"
    "Team"       = "SA"
  }
}




variable "master_initial_node_count_per_zone" {
  description = "Number total initial instances per zone"
  type        = number
  default     = 1
}


variable "master_surge_count" {
  description = "autoscale surge count"
  type        = number
  default     = 10
}


variable "master_instance_count_per_zone" {
  description = "Number of master instances per zone"
  type        = number
  default     = 1
}


variable "master_max_instance_count_per_zone" {
  description = "Max Number of master instances per zone"
  type        = number
  default     = 1
}

variable "master_instance_type" {
  description = "Master instance type"
  type        = string
  default     = "e2-standard-8"
}

variable "master_instance_k8s_label" {
  description = "master instance k8s label"
  type        = map
  default     = {"nodetype"="master"}
}

variable "master_volume" {
  description = "Volume in GB"
  type        = number
  default     = 500
}

variable "master_volume_type" {
  description = "disk type"
  type        = string
  default     = "pd-ssd"
}


variable "kibana_instance_count" {
  description = "Number of kibana instances"
  type        = number
  default     = 1
}


variable "kibana_instance_type" {
  description = "Kibana instance type"
  type        = string
  default     = "e2-standard-8"
}

variable "kibana_instance_k8s_label" {
  description = "kibana instance k8s label"
  type        = map
  default     = {"nodetype"="kibana"}
}

variable "kibana_volume" {
  description = "Volume in GB"
  type        = number
  default     = 2000
}

variable "kibana_volume_type" {
  description = "disk type"
  type        = string
  default     = "pd-ssd"
}

variable "hot_surge_count" {
  description = "autoscale surge count"
  type        = number
  default     = 10
}

variable "hot_initial_node_count_per_zone" {
  description = "Number total initial instances, not per zone"
  type        = number
  default     = 1
}

variable "hot_instance_count_per_zone" {
  description = "Number of hot instances per zone"
  type        = number
  default     = 1
}


variable "hot_max_instance_count_per_zone" {
  description = "Max Number of hot instances per zone"
  type        = number
  default     = 20
}


variable "hot_instance_type" {
  description = "Hot instance type"
  type        = string
  default     = "e2-standard-32"
}

variable "hot_instance_k8s_label" {
  description = "hot instance k8s label"
  type        = map
  default     = {"nodetype"="hot"}
}

variable "hot_volume" {
  description = "Volume in GB"
  type        = number
  default     = 2000
}

variable "hot_volume_type" {
  description = "disk type"
  type        = string
  default     = "pd-ssd"
}

variable "warm_surge_count" {
  description = "autoscale surge count"
  type        = number
  default     = 10
}

variable "warm_initial_node_count_per_zone" {
  description = "Number total initial instances per zone"
  type        = number
  default     = 0
}

variable "warm_instance_count_per_zone" {
  description = "Number of warm instances per zone"
  type        = number
  default     = 0
}

variable "warm_max_instance_count_per_zone" {
  description = "Max Number of warm instances per zone"
  type        = number
  default     = 10
}

variable "warm_instance_type" {
  description = "warm instance type"
  type = string
  default     = "e2-standard-32"
}


variable "warm_instance_k8s_label" {
  description = "warm instance k8s label"
  type        = map
  default     = {"nodetype"="warm"}
}

variable "warm_volume" {
  description = "Volume in GB"
  type        = number
  default     = 7500
}

variable "warm_volume_type" {
  description = "disk type"
  type        = string
  default     = "pd-ssd"
}

variable "cold_surge_count" {
  description = "autoscale surge count"
  type        = number
  default     = 10
}

variable "cold_initial_node_count_per_zone" {
  description = "Number total initial instances per zone"
  type        = number
  default     = 0
}

variable "cold_instance_count_per_zone" {
  description = "Number of cold instances per zone"
  type        = number
  default     = 0
}


variable "cold_max_instance_count_per_zone" {
  description = "Max Number of cold instances per zone"
  type        = number
  default     = 10
}

variable "cold_instance_type" {
  description = "Cold instance type"
  type = string
  default     = "e2-standard-32"
}


variable "cold_instance_k8s_label" {
  description = "cold instance k8s label"
  type        = map
  default     = {"nodetype"="cold"}
}


variable "cold_volume" {
  description = "Volume in GB"
  type        = number
  default     = 7500
}

variable "cold_volume_type" {
  description = "disk type"
  type        = string
  default     = "pd-ssd"
}

variable "frozen_surge_count" {
  description = "autoscale surge count"
  type        = number
  default     = 10
}

variable "frozen_initial_node_count_per_zone" {
  description = "Number total initial instances per zone"
  type        = number
  default     = 0
}


variable "frozen_instance_count_per_zone" {
  description = "Number of frozen instances per zone"
  type        = number
  default     = 0
}


variable "frozen_max_instance_count_per_zone" {
  description = "Max Number of frozen instances per zone"
  type        = number
  default     = 10
}

variable "frozen_instance_type" {
  description = "frozen instance type"
  type = string
  default     = "e2-standard-32"
}

variable "frozen_instance_k8s_label" {
  description = "frozen instance k8s label"
  type        = map
  default     = {"nodetype"="frozen"}
}

variable "frozen_volume" {
  description = "Volume in GB"
  type        = number
  default     = 7500
}

variable "frozen_volume_type" {
  description = "disk type"
  type        = string
  default     = "pd-ssd"
}

variable "ml_surge_count" {
  description = "autoscale surge count"
  type        = number
  default     = 10
}

variable "ml_initial_node_count_per_zone" {
  description = "Number total initial instances per zone"
  type        = number
  default     = 0
}


variable "ml_instance_count_per_zone" {
  description = "Number of ml instances per zone"
  type        = number
  default     = 0
}

variable "ml_max_instance_count_per_zone" {
  description = "Max Number of ml instances per zone"
  type        = number
  default     = 10
}

variable "ml_instance_type" {
  description = "ML instance type"
  type        = string
  default     = "e2-standard-32"
}

variable "ml_instance_k8s_label" {
  description = "ml instance k8s label"
  type        = map
  default     = {"nodetype"="ml"}
}

variable "ml_volume" {
  description = "Volume in GB"
  type        = number
  default     = 2000
}

variable "ml_volume_type" {
  description = "disk type"
  type        = string
  default     = "pd-ssd"
}

variable "util_instance_count" {
  description = "Number of util instances"
  type        = number
  default     = 1
}

variable "util_instance_type" {
  description = "util instance type"
  type        = string
  default     = "e2-standard-4"
}

variable "util_instance_k8s_label" {
  description = "util instance k8s label"
  type        = map
  default     = {"nodetype"="util"}
}

variable "util_volume" {
  description = "Volume in GB"
  type        = number
  default     =  200
}

variable "util_volume_type" {
  description = "disk type"
  type        = string
  default     = "pd-ssd"
}

variable "es_version" {
  description = "elasticsearch version"
  type = string
  default = "8.5.2"
}

variable "master_pod_count" {
  description = "number of master pods"
  type = number
  default = 1
}

variable "master_pod_cpu" {
  description = "master pod cpu request"
  type = string
  default = "6500m"
}

variable "master_pod_memory" {
  description = "master pod memory request"
  type = string
  default = "11264Mi"
}

variable "master_pod_storage" {
  description = "master pod storage request"
  type = string
  default = "140Gi"
}

variable "master_pod_ES_JAVA_OPTS" {
  description = "master pod ES_JAVA_OPTS"
  type = string
  default = " "
  #default = "-Xms8g -Xmx8g"
}


variable "kibana_pod_cpu" {
  description = "kibana pod cpu request"
  type = string
  default = "1000m"
}

variable "kibana_pod_memory" {
  description = "kibana pod memory request"
  type = string
  default = "1Gi"
}

variable "kibana_pod_count" {
  description = "number of kibana pods"
  type = number
  default = 1
}

variable "hot_pod_count" {
  description = "number of hot pods"
  type = number
  default = 3
}

variable "hot_pod_cpu" {
  description = "hot pod cpu request"
  type = string
  default = "30000m"
}

variable "hot_pod_memory" {
  description = "hot pod memory request"
  type = string
  default = "53248Mi"
}

variable "hot_pod_storage" {
  description = "hot pod storage request"
  type = string
  default = "1600Gi"
}

variable "hot_pod_ES_JAVA_OPTS" {
  description = "hot pod ES_JAVA_OPTS"
  type = string
  default = " "
  #default = "-Xms8g -Xmx8g"
}


variable "warm_pod_count" {
  description = "number of warm pods"
  type = number
  default = 0
}

variable "warm_pod_cpu" {
  description = "warm pod cpu request"
  type = string
  default = "14000m"
}

variable "warm_pod_memory" {
  description = "warm pod memory request"
  type = string
  default = "53248Mi"
}

variable "warm_pod_storage" {
  description = "warm pod storage request"
  type = string
  default = "5000Gi"
}

variable "warm_pod_ES_JAVA_OPTS" {
  description = "warm pod ES_JAVA_OPTS"
  type = string
  default = " "
  #default = "-Xms8g -Xmx8g"
}

variable "cold_pod_count" {
  description = "number of cold pods"
  type = number
  default = 0
}
variable "cold_pod_cpu" {
  description = "cold pod cpu request"
  type = string
  default = "46000m"
}

variable "cold_pod_memory" {
  description = "cold pod memory request"
  type = string
  default = "11264Mi"
}

variable "cold_pod_storage" {
  description = "cold pod storage request"
  type = string
  default = "140Gi"
}

variable "cold_pod_ES_JAVA_OPTS" {
  description = "cold pod ES_JAVA_OPTS"
  type = string
  default = " "
  #default = "-Xms8g -Xmx8g"
}

variable "frozen_pod_count" {
  description = "number of frozen pods"
  type = number
  default = 0
}
variable "frozen_pod_cpu" {
  description = "frozen pod cpu request"
  type = string
  default = "94000m"
}

variable "frozen_pod_memory" {
  description = "frozen pod memory request"
  type = string
  default = "11264Mi"
}

variable "frozen_pod_storage" {
  description = "frozen pod storage request"
  type = string
  default = "140Gi"
}

variable "frozen_pod_ES_JAVA_OPTS" {
  description = "frozen pod ES_JAVA_OPTS"
  type = string
  default = " "
  #default = "-Xms8g -Xmx8g"
}

variable "ml_pod_count" {
  description = "number of ml pods"
  type = number
  default = 0
}
variable "ml_pod_cpu" {
  description = "ml pod cpu request"
  type = string
  default = "14000m"
}

variable "ml_pod_memory" {
  description = "ml pod memory request"
  type = string
  default = "11264Mi"
}

variable "ml_pod_storage" {
  description = "ml pod storage request"
  type = string
  default = "140Gi"
}

variable "ml_pod_ES_JAVA_OPTS" {
  description = "ml pod ES_JAVA_OPTS"
  type = string
  default = " "
  #default = "-Xms8g -Xmx8g"
}

variable "eck_namespace" {
  description = "eck namespace"
  type = string
  default = "default"
}


variable "master_pod_roles" {
  description = "master pod roles"
  type = string
  default = "master"
}

variable "hot_pod_roles" {
  description = "hot pod roles"
  type = string
  default = "data_hot, data_content, ingest"
}

variable "warm_pod_roles" {
  description = "warm pod roles"
  type = string
  default = "data_warm, data_content"
}

variable "cold_pod_roles" {
  description = "cold pod roles"
  type = string
  default = "data_cold"
}

variable "frozen_pod_roles" {
  description = "frozen pod roles"
  type = string
  default = "data_frozen"
}

variable "ml_pod_roles" {
  description = "ml pod roles"
  type = string
  default = "ml, remote_cluster_client"
}


