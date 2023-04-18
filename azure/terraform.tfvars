######################## Terraform Variables ###################################

# This file is required to succesfully deploy 1ClickECK. To customize the
# deployment just uncomment the variable below and change its value.
# 
# NOTE: Your gcp cloud cli must be set with your credentials for the automation
# to run. Be sure to run `gcloud auth login` before running this script:
# https://cloud.google.com/sdk/gcloud/reference/auth/login
#
# The default values are defined in variables.tf, do NOT modify that file.

#======================= Deployment Configuration ==============================

# House keeping tags. For internal Elastic projects, please follow the cloud
# resource tagging guidelines.

tags = {
    "division" = "field"
    "org" = "sa"
    "team" = "amer"
    "project" = "username" # Project name (shared) or username (individual)
}

resource_group_location="eastus"



#----------------------- Cloud Provider ----------------------------------------

#automation_name= "1ClickECK"

# Set these Azure variables 

#export ARM_CLIENT_ID=""
#export ARM_CLIENT_SECRET=""
#export ARM_SUBSCRIPTION_ID=""
#export ARM_TENANT_ID=""

# Set authentication here (less secure)
#aks_service_principal_app_id=""
#aks_service_principal_client_secret=""

# Or export these env varialbles (more secure)
#export TF_VAR_aks_service_principal_app_id=""
#export TF_VAR_aks_service_principal_client_secret=""

#aks_version= "1.24.6"

#dns_prefix= "oneclickeck"
#resource_group_location= "eastus"

# Prefix of the resource group name that's combined with a random ID so name is
# unique in your Azure subscription.
#resource_group_name_prefix= 

#----------------------- Kubernetes Environment --------------------------------

# Cloud provider-specific options that define the shape and size of the k8s
# cluster. Each k8s node gets specific hardware instance types and storage
# classes. One k8s instance can host multiple Elasticsearch nodes (pods).
#
# This determines the hardware footprint, or billiable size, of the deployment.

#master_instance_count=1
#master_max_instance_count=1
#master_instance_type= "standard_D8ads_v5"
#master_instance_k8s_label= {"nodetype"="master"}
#master_accept_ingest=false

#kibana_instance_count= 10
#kibana_max_instance_count= 2
#kibana_instance_type= "standard_B2ms"
#kibana_instance_k8s_label= {"nodetype"="kibana"}
#kibana_capacity_type=  "ON_DEMAND"  # ON_DEMAND, SPOT

#hot_instance_count= 3
#hot_max_instance_count= 3
#hot_instance_type=  "standard_D32pls_v5"
#hot_instance_k8s_label= {"nodetype"="hot"}
#hot_accept_ingest=true


#warm_instance_count= 0
#warm_max_instance_count= 0
#warm_instance_type= "standard_E16ads_v5"
#warm_instance_k8s_label= {"nodetype"="warm"}
#warm_accept_ingest=true


#cold_instance_count= 0
#cold_max_instance_count= 0
#cold_instance_type= "standard_E48ads_v5"
#cold_instance_k8s_label= {"nodetype"="cold"}
#cold_accept_ingest=false


#frozen_instance_count= 0
#frozen_max_instance_count= 0
#frozen_instance_type= "standard_E96ads_v5"
#frozen_instance_k8s_label= {"nodetype"="frozen"}
#frozen_accept_ingest=false


#ml_instance_count= 0
#ml_max_instance_count= 0
#ml_instance_type= "standard_D16ads_v5"
#ml_instance_k8s_label= {"nodetype"="ml"}
#ml_accept_ingest=false

#logstash_instance_count= 0
#logstash_max_instance_count= 0
#logstash_instance_type= "standard_D16ads_v5"
#logstash_instance_k8s_label= {"nodetype"="ml"}

#windows_instance_count= 1
#windows_max_instance_count= 0
#windows_instance_type= "standard_D16ads_v5"
#windows_instance_k8s_label= {"nodetype"="windows"}
#windows_os_type = "Windows"
#windows_os_sku = "Windows2022"
#windows_os_disk_size_gb" = 30
#windows_user_name = "azureuser"
#windows_password = "P@ssw0rd1234!"


#util_instance_count= 1
#util_instance_type= "standard_B2s"
#util_instance_k8s_label= {"nodetype"="util"}

#openebs_helm_chart_version="3.3.1"

#======================= Elastic Stack =========================================

# Elastic-specific configuraiton options

#----------------------- Elastic Cloud Kubernetes ------------------------------

#eck_version= "2.6.1"
#eck_namespace= "default"

#----------------------- Elasticsearch Cluster ---------------------------------

# Defines the number and size of Elasticsearch nodes. Each node is hosted in a
# Kubernetes pod. The total pod count will be distributed across the k8s
# instances in the regions defined above.

#es_version= "8.5.3"

#master_pod_ES_JAVA_OPTS= "-Xms8g -Xmx8g"
#master_pod_count= 1
#master_pod_cpu= "6500m"
#master_pod_memory= "11264Mi"
#master_pod_roles= "master"
#master_pod_storage= "140Gi"
#master_pod_storage_class = "managed-premium"


#hot_pod_ES_JAVA_OPTS= "-Xms8g -Xmx8g"
#hot_pod_count= 3
#hot_pod_cpu= "30000m"
#hot_pod_memory= "53248Mi"
#hot_pod_roles= "data_hot, data_content, ingest"
#hot_pod_storage= "1600Gi"
#hot_pod_storage_class = "openebs-hostpath"

#warm_pod_ES_JAVA_OPTS= "-Xms8g -Xmx8g"
#warm_pod_count= 1
#warm_pod_cpu= "14000m"
#warm_pod_memory= "53248Mi"
#warm_pod_roles= "data_warm, data_content"
#warm_pod_storage= "5000Gi"
#warm_pod_storage_class = "openebs-hostpath"

#cold_pod_ES_JAVA_OPTS= "-Xms8g -Xmx8g"
#cold_pod_count= 1
#cold_pod_cpu= "46000m"
#cold_pod_memory= "11264Mi"
#cold_pod_roles= "data_cold"
#cold_pod_storage= "140Gi"
#cold_pod_storage_class = "managed-premium"

#frozen_pod_ES_JAVA_OPTS= "-Xms8g -Xmx8g"
#frozen_pod_count= 1
#frozen_pod_cpu= "94000m"
#frozen_pod_memory= "11264Mi"
#frozen_pod_roles= "data_frozen"
#frozen_pod_storage= "140Gi"
#frozen_pod_storage_class = "managed-premium"

#ml_pod_ES_JAVA_OPTS= "-Xms8g -Xmx8g"
#ml_pod_count= 1
#ml_pod_cpu= "14000m"
#ml_pod_memory= "11264Mi"
#ml_pod_roles= "ml, remote_cluster_client"
#ml_pod_storage= "140Gi"
#ml_pod_storage_class = "managed-premium"

#kibana_pod_count= 1
#kibana_pod_cpu= "1000m"
#kibana_pod_memory= "1Gi"


#----------------------- Open Telemetry ---------------------------------
#otel_instance_count= 0
#otel_instance_type =  "standard_F32s_v2"
#otel_instance_k8s_label = {"nodetype"="otel"}

##high recommended to use env variables instead of setting the url and token in a file
#export TF_VAR_es_apm_url="xxxx"
#export TF_VAR_es_apm_token="xxxx"

#es_apm_url= "xxxelastic-cloud.com:443" without https:// prefix
#es_apm_token="xxx" your Elastic APM secret token
#otel_chart_version= "0.19.5"