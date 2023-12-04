######################## Terraform Variables ###################################

# This file is required to succesfully deploy ElasticKonductor. To customize the
# deployment just uncomment the variable below and change its value.
# 
# NOTE: Your gcp cloud cli must be set with your credentials for the automation
# to run. Be sure to run `gcloud auth login` before running this script:
# https://cloud.google.com/sdk/gcloud/reference/auth/login
#
# The default values are defined in variables.tf, do NOT modify that file.

#======================= Deployment Configuraiton ==============================

# House keeping tags. For internal Elastic projects, please follow the cloud
# resource tagging guidelines.

##gcp has strick enforcement on naming. please use lower case with no special characters
tags = {
    "division" = "field"
    "org" = "sa"
    "team" = "amer"
    "project" = "username" # Project name (shared) or username (individual)
}


region= "us-central1"
zones= ["us-central1-a", "us-central1-b", "us-central1-c"]

gcp_project="REPLACE-WITH-YOUR-GCP-PROJECT"



#----------------------- Cloud Provider ----------------------------------------


#automation_name= "konductor"

# Defines where konductor will deploy the new Kubernetes cluster



#region= "us-central1"
#zones= ["us-central1-a", "us-central1-b", "us-central1-c"]

#release_channel= "STABLE"

#gke_version="1.27." ##must have dot after major release number as the automation fetches minor version

#gke_auto_upgrade=true
#gke_auto_repair=false
#gke_image_type="UBUNTU_CONTAINERD"



#gke_subnetwork_cidr = "10.136.32.0/20"
#gke_pod_range_cidr = "10.136.144.0/20"
#gke_service_range_cidr = "10.136.109.192/26"


#----------------------- Kubernetes Environment --------------------------------

# Cloud provider-specific options that define the shape and size of the k8s
# cluster. Each k8s node gets specific hardware instance types and storage
# classes. One k8s instance can host multiple Elasticsearch nodes (pods).
#
# This determines the hardware footprint, or billiable size, of the deployment.


#master_initial_node_count_per_zone=1
#master_instance_count_per_zone=1
#master_instance_k8s_label= {"nodetype"="master"}
#master_instance_type= "n2-standard-8"
#master_max_instance_count_per_zone=10
#master_surge_count=10
#master_volume_type= "pd-ssd"
#master_accept_ingest=false
#master_accept_search=false
#master_create_node_pool=true

#kibana_instance_count=1
#kibana_instance_k8s_label= {"nodetype"="kibana"}
#kibana_instance_type= ""
#kibana_volume_type= "pd-ssd"
#kibana_create_node_pool=true

#hot_initial_node_count_per_zone=2
#hot_instance_count_per_zone=2
#hot_instance_k8s_label= {"nodetype"="hot"}
#hot_instance_type=  "n2-standard-32"
#hot_max_instance_count_per_zone=10
#hot_surge_count=10
#hot_volume_type= "pd-ssd"
#hot_accept_ingest=true
#hot_accept_search=true
#hot_create_node_pool=true
#hot_local_ssd_count = 0  ##each unit will provide 375 GB

#warm_initial_node_count_per_zone=1
#warm_instance_count_per_zone=1
#warm_instance_k8s_label= {"nodetype"="warm"}
#warm_max_instance_count_per_zone=10
#warm_surge_count=10
#warm_instance_type= ""
#warm_volume_type= "pd-ssd"
#warm_accept_ingest=true
#warm_accept_search=false
#warm_create_node_pool=true
#warm_local_ssd_count = 0

#cold_initial_node_count_per_zone=1
#cold_instance_count_per_zone=1
#cold_instance_k8s_label= {"nodetype"="cold"}
#cold_instance_type= ""
#cold_max_instance_count_per_zone=10
#cold_surge_count=10
#cold_volume_type= "pd-ssd"
#cold_accept_ingest=false
#cold_accept_search=false
#cold_create_node_pool=true
#cold_local_ssd_count = 0


#frozen_initial_node_count_per_zone=1
#frozen_instance_count_per_zone=1
#frozen_instance_k8s_label= {"nodetype"="frozen"}
#frozen_instance_type= ""
#frozen_max_instance_count_per_zone=10
#frozen_surge_count=10
#frozen_volume_type= "pd-ssd"
#frozen_accept_ingest=false
#frozen_accept_search=false
#frozen_create_node_pool=true
#frozen_local_ssd_count = 0

#ml_initial_node_count_per_zone=1
#ml_instance_count_per_zone=1
#ml_instance_k8s_label= {"nodetype"="ml"}
#ml_instance_type= "crazyinstancetype"
#ml_max_instance_count_per_zone=10
#ml_surge_count=10
#ml_volume_type= "pd-ssd"
#ml_accept_ingest=false
#ml_accept_search=false
#ml_create_node_pool=true
#ml_local_ssd_count = 1


#entsearch_instance_count = 3
#entsearch_instance_type= "n2-standard-32"
#entsearch_instance_k8s_label = {"nodetype"="entsearch"}
#entsearch_volume = 500
#entsearch_volume_type = "pd-ssd"
#entsearch_create_node_pool = true
#entsearch_local_ssd_count = 1


#fleet_instance_count=1
#fleet_instance_k8s_label= {"nodetype"="fleet"}
#fleet_instance_type= "e2-standard-8"
#fleet_volume_type= "pd-ssd"
#fleet_create_node_pool=true


#util_instance_count= 1
#util_instance_k8s_label= {"nodetype"="util"}
#util_instance_type= ""
#util_volume_type= "pd-ssd"
#util_local_ssd_count = 1


#openebs_helm_chart_version="3.3.1"

#======================= Elastic Stack =========================================

# Elastic-specific configuraiton options

#----------------------- Elastic Cloud Kubernetes ------------------------------

#eck_version= "2.9.0"
#eck_namespace= "default"

#----------------------- Elasticsearch Cluster ---------------------------------

# Defines the number and size of Elasticsearch nodes. Each node is hosted in a
# Kubernetes pod. The total pod count will be distributed across the k8s
# instances in the regions defined above.

#es_version= "8.9.1"

#master_pod_ES_JAVA_OPTS= "-Xms8g -Xmx8g"
#master_pod_count= 3
#master_pod_cpu= "6500m"
#master_pod_memory= "11264Mi"
#master_pod_roles= "master, remote_cluster_client"
#master_pod_storage= "140Gi"
#master_pod_storage_class = "local-storage"

#hot_pod_ES_JAVA_OPTS= "-Xms8g -Xmx8g"
#hot_pod_count= 3
#hot_pod_cpu= "30000m"
#hot_pod_memory= "53248Mi"
#hot_pod_roles= "data_hot, data_content, ingest, remote_cluster_client"
#hot_pod_storage= "1600Gi"
#hot_pod_storage_class = "local-storage"

#warm_pod_ES_JAVA_OPTS= "-Xms8g -Xmx8g"
#warm_pod_count= 0
#warm_pod_cpu= "14000m"
#warm_pod_memory= "53248Mi"
#warm_pod_roles= "data_warm, data_content, remote_cluster_client"
#warm_pod_storage= "5000Gi"
#warm_pod_storage_class = "local-storage"

#cold_pod_ES_JAVA_OPTS= "-Xms8g -Xmx8g"
#cold_pod_count= 0
#cold_pod_cpu= "46000m"
#cold_pod_memory= "11264Mi"
#cold_pod_roles= "data_cold, remote_cluster_client"
#cold_pod_storage= "140Gi"
#cold_pod_storage_class = "local-storage"

#frozen_pod_ES_JAVA_OPTS= "-Xms8g -Xmx8g"
#frozen_pod_count= 0
#frozen_pod_cpu= "94000m"
#frozen_pod_memory= "11264Mi"
#frozen_pod_roles= "data_frozen, remote_cluster_client"
#frozen_pod_storage= "140Gi"
#frozen_pod_storage_class = "local-storage"

#ml_pod_ES_JAVA_OPTS= "-Xms8g -Xmx8g"
#ml_pod_count= 1
#ml_pod_cpu= "14000m"
#ml_pod_memory= "11264Mi"
#ml_pod_roles= "ml, remote_cluster_client"
#ml_pod_storage= "140Gi"
#ml_pod_storage_class = "local-storage"

#kibana_pod_count= 1
#kibana_pod_cpu= "1000m"
#kibana_pod_memory= "1Gi"


#entsearch_pod_count = 1
#entsearch_pod_cpu = "4"
#entsearch_pod_memory = "20Gi"
#entsearch_pod_storage = "200Gi"
#entsearch_pod_ES_JAVA_OPTS = " "
#entsearch_accept_ingest = "false"
#entsearch_accept_search=false
#entsearch_pod_storage_class = "local-storage"



#fleet_pod_cpu= "4"
#fleet_pod_memory = "20Gi"
#fleet_pod_count= 1




#----------------------- istio ---------------------------------
#istio_helm_base_chart_version= "1.17.2" 
#Run this to find available versions: helm search repo istio/base --versions
#istiod_helm_chart_version=1.17.2


#----------------------- Open Telemetry ---------------------------------
#otel_instance_count= 0
#otel_instance_type =  "e2-standard-32"
#otel_instance_k8s_label = {"nodetype"="otel"}

##high recommended to use env variables instead of setting the url and token in a file
#export TF_VAR_es_apm_url="xxxx" #without https:// prefix
#export TF_VAR_es_apm_token="xxxx"

#es_apm_url= "xxxelastic-cloud.com:443" #without https:// prefix
#es_apm_token="xxx" #your Elastic APM secret token
