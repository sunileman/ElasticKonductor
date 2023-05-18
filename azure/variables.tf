# DO NOT MODIFIY
# Put any changes or customizations in terraform.tfvars

# The following two variable declarations are placeholder references.

variable "aks_service_principal_app_id" {
  default = ""
}

variable "aks_service_principal_client_secret" {
  default = ""
}

variable "dns_prefix" {
  default = "oneclickeck"
}

variable "resource_group_location" {
  description = "Location of the resource group."
  default = "eastus"
}

variable "resource_group_name_prefix" {
  default     = "rg"
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}

variable "aks_version" {
  description = "AKS Version"
  type        = string
  default     = "1.26.3"
}

variable "eck_version" {
  description = "ECK Version"
  type        = string
  default = "2.7.0"
}

variable "project" {
  description = "ClickDeployment Name"
  type = string
  default = "1ClickECK"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default = {
    "project"  = "1ClickECK"
    "team"     = "someteam"
    "org"      = "sa"
    "division" = "field"
  }
}

variable "k8s_master_instance_type" {
  description = "k8s Master instance type"
  type        = string
  default     = "Standard_D2_v2"
}

variable "master_instance_count" {
  description = "Number of master instances"
  type        = number
  default     = 1
}

variable "master_max_instance_count" {
  description = "Max Number of master instances"
  type        = number
  default     = 3
}

variable "master_instance_type" {
  description = "Master instance type"
  type        = string
  default     = "standard_D8ads_v5"
}

variable "master_instance_k8s_label" {
  description = "Master instance k8s label"
  type        = map
  default     = {"nodetype"="master"}
}

variable "kibana_instance_count" {
  description = "Number of kibana instances"
  type        = number
  default     = 2
}

variable "kibana_max_instance_count" {
  description = "Max Number of kibana instances"
  type        = number
  default     = 10
}

variable "kibana_instance_type" {
  description = "Kibana instance type"
  type        = string
  default     = "standard_B2ms"
}

variable "kibana_instance_k8s_label" {
  description = "kibana instance k8s label"
  type        = map
  default     = {"nodetype"="kibana"}
}

variable "hot_instance_count" {
  description = "Number of hot instances"
  type        = number
  default     = 3
}

variable "hot_max_instance_count" {
  description = "Max Number of hot instances"
  type        = number
  default     = 10
}

variable "hot_instance_type" {
  description = "Hot instance type"
  type        = string
  default     =  "standard_F32s_v2"
}

variable "hot_instance_k8s_label" {
  description = "hot instance k8s label"
  type        = map
  default     = {"nodetype"="hot"}
}

variable "warm_instance_count" {
  description = "Number of warm instances"
  type        = number
  default     = 0
}

variable "warm_max_instance_count" {
  description = "Max Number of warm instances"
  type        = number
  default     = 10
}

variable "warm_instance_type" {
  description = "warm instance type"
  type = string
  default     = "standard_E16ads_v5"
}

variable "warm_instance_k8s_label" {
  description = "warm instance k8s label"
  type        = map
  default     = {"nodetype"="warm"}
}

variable "cold_instance_count" {
  description = "Number of cold instances"
  type        = number
  default     = 0
}

variable "cold_max_instance_count" {
  description = "Max Number of cold instances"
  type        = number
  default     = 10
}

variable "cold_instance_type" {
  description = "Cold instance type"
  type = string
  default     = "standard_E48ads_v5"
}

variable "cold_instance_k8s_label" {
  description = "cold instance k8s label"
  type        = map
  default     = {"nodetype"="cold"}
}

variable "frozen_instance_count" {
  description = "Number of frozen instances"
  type        = number
  default     = 0
}

variable "frozen_max_instance_count" {
  description = "Max Number of frozen instances"
  type        = number
  default     = 10
}

variable "frozen_instance_type" {
  description = "frozen instance type"
  type = string
  default     = "standard_E96ads_v5"
}

variable "frozen_instance_k8s_label" {
  description = "frozen instance k8s label"
  type        = map
  default     = {"nodetype"="frozen"}
}

variable "ml_instance_count" {
  description = "Number of ml instances"
  type        = number
  default     = 0
}

variable "ml_max_instance_count" {
  description = "Max Number of ml instances"
  type        = number
  default     = 10
}

variable "ml_instance_type" {
  description = "ML instance type"
  type = string
  default     = "standard_D16ads_v5"
}

variable "ml_instance_k8s_label" {
  description = "ml instance k8s label"
  type        = map
  default     = {"nodetype"="ml"}
}

variable "util_instance_count" {
  description = "Number of util instances"
  type        = number
  default     = 1
}

variable "util_instance_type" {
  description = "util instance type"
  type = string
  default     = "standard_F32s_v2"
}

variable "util_instance_k8s_label" {
  description = "util instance k8s label"
  type        = map
  default     = {"nodetype"="util"}
}

variable "logstash_instance_count" {
  description = "Number of logstash instances"
  type        = number
  default     = 0
}

variable "logstash_max_instance_count" {
  description = "Max Number of logstash instances"
  type        = number
  default     = 10
}

variable "logstash_instance_type" {
  description = "logstash instance type"
  type        = string
  default     =  "standard_F32s_v2"
}

variable "logstash_instance_k8s_label" {
  description = "logstash instance k8s label"
  type        = map
  default     = {"nodetype"="logstash"}
}


variable "windows_instance_count" {
  description = "Number of windows instances"
  type        = number
  default     = 0
}

variable "windows_max_instance_count" {
  description = "Max Number of windows instances"
  type        = number
  default     = 10
}

variable "windows_instance_type" {
  description = "windows instance type"
  type        = string
  default     =  "standard_F32s_v2"
}

variable "windows_instance_k8s_label" {
  description = "windows instance k8s label"
  type        = map
  default     = {"nodetype"="windows"}
}

variable "windows_os_type" {
  description = "windows os type"
  type        = string
  default     = "Windows"
}

variable "windows_os_sku" {
  description = "windows os sku"
  type        = string
  default     = "Windows2022"
}

variable "windows_os_disk_size_gb" {
  description = "windows instance os storage"
  type        = number
  default     = 35
}

variable "windows_user_name" {
  description = "windows  os sku"
  type        = string
  default     = "azureuser"
}

variable "windows_password" {
  description = "windows instance os storage"
  type        = string
  default     = "P@ssw0rd12abc6ad34!"
}

variable "otel_instance_count" {
  description = "Number of otel instances"
  type        = number
  default     = 0
}

variable "otel_instance_type" {
  description = "otel instance type"
  type        = string
  default     =  "standard_F32s_v2"
}

variable "otel_instance_k8s_label" {
  description = "otel instance k8s label"
  type        = map
  default     = {"nodetype"="otel"}
}

variable "es_version" {
  description = "elasticsearch version"
  type = string
  default = "8.6.2"
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

variable "master_accept_ingest" {
  description = "pod accepts ingest"
  type = string
  default = "false"
}

variable "master_pod_storage_class" {
  description = "pod storage class"
  type = string
  default = "local-storage"
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

variable "hot_accept_ingest" {
  description = "pod accepts ingest"
  type = string
  default = "true"
}

variable "hot_pod_storage_class" {
  description = "pod storage class"
  type = string
  default = "local-storage"
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

variable "warm_accept_ingest" {
  description = "pod accepts ingest"
  type = string
  default = "true"
}

variable "warm_pod_storage_class" {
  description = "pod storage class"
  type = string
  default = "local-storage"
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

variable "cold_accept_ingest" {
  description = "pod accepts ingest"
  type = string
  default = "false"
}

variable "cold_pod_storage_class" {
  description = "pod storage class"
  type = string
  default = "local-storage"
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

variable "frozen_accept_ingest" {
  description = "pod accepts ingest"
  type = string
  default = "false"
}

variable "frozen_pod_storage_class" {
  description = "pod storage class"
  type = string
  default = "local-storage"
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

variable "ml_accept_ingest" {
  description = "pod accepts ingest"
  type = string
  default = "false"
}

variable "ml_pod_storage_class" {
  description = "pod storage class"
  type = string
  default = "local-storage"
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

variable "lbname" {
  description = "Kibana Load Balancer Name"
  type = string
  default = "changeme"
}

variable "lb2name" {
  description = "Kibana Load Balancer Name port 9200"
  type = string
  default = "changeme2"
}

variable "openebs_helm_chart_version" {
  description = "OpenEBS chart version"
  type = string
  default = "3.3.1"
}

variable "istio_helm_base_chart_version" {
  description = "istio chart base version"
  type = string
  default = "1.17.2"
  #helm search repo istio/base --versions
}

variable "istiod_helm_chart_version" {
  description = "istiod chart base version"
  type = string
  default = "1.17.2"
  #helm search repo istio/istiod --versions
}

variable "ksm_helm_chart_version" {
  description = "KSM chart version"
  type = string
  default = "4.32.0"
  ##https://github.com/kubernetes/kube-state-metrics#compatibility-matrix
}

variable "es_apm_token" {
  description = "ElasticSearch APM Token"
  type = string
  default = ""
}

variable "es_apm_url" {
  description = "ElasticSearch APM URL"
  type = string
  default = ""
}


variable "network_plugin" {
  description = "Network plugin"
  type = string
  default = "azure"
}

variable "load_balancer_sku" {
  description = "Load balancer sku"
  type = string
  default = "standard"
}

variable "identity_type" {
  description = "Ddentity Type"
  type = string
  default = "SystemAssigned"
}
