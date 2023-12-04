######################## Terraform Variables ###################################

# This file is required to succesfully deploy ElasticKonductor. To customize the
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
    "enddate" = "05012024" #MMDDYYYY
}

region= "us-east-1"







#----------------------- Cloud Provider ----------------------------------------
#automation_name= "konductor"

# Optinally set aws creds here (less secure) 
#aws_access_key="your-key"
#aws_access_key="your-key"

# Or export these environment variables (more secure)
#export TF_VAR_aws_access_key="your access key"
#export TF_VAR_aws_secret_key="your secret yet"

#eks_version="1.24"

#----------------------- Kubernetes Environment --------------------------------

# Cloud provider-specific options that define the shape and size of the k8s
# cluster. Each k8s node gets specific hardware instance types and storage
# classes. One k8s instance can host multiple Elasticsearch nodes (pods).
#
# This determines the hardware footprint, or billiable size, of the deployment.

#availability_zones_count= 2
#client_access_cidr= ["0.0.0.0/0"]
#endpoint_private_access= "false"
#endpoint_public_access= "true"
#region= "us-east-1"

#master_ami_type= "AL2_ARM_64" # AL2_x86_64, AL2_x86_64_GPU, AL2_ARM_64, CUSTOM
#master_capacity_type="ON_DEMAND"  # ON_DEMAND, SPOT
#master_instance_count=1
#master_instance_k8s_label= {"nodetype"="master"}
#master_instance_type= ["m6g.2xlarge"]
#master_max_instance_count=2
#master_accept_ingest=false
#master_accept_search=false

#kibana_ami_type= "AL2_x86_64" # AL2_x86_64, AL2_x86_64_GPU, AL2_ARM_64, CUSTOM
#kibana_capacity_type=  "ON_DEMAND"  # ON_DEMAND, SPOT
#kibana_instance_count= 2
#kibana_instance_k8s_label= {"nodetype"="kibana"}
#kibana_instance_type= ["t2.medium"]
#kibana_max_instance_count=10

#hot_ami_type= "AL2_ARM_64" # AL2_x86_64, AL2_x86_64_GPU, AL2_ARM_64, CUSTOM
#hot_capacity_type=  "ON_DEMAND"  # ON_DEMAND, SPOT
#hot_instance_count= 3
#hot_instance_k8s_label= {"nodetype"="hot"}
#hot_instance_type= ["c6g.8xlarge"]
#hot_max_instance_count=10
#hot_accept_ingest=true
#hot_accept_search=true



#warm_ami_type= "AL2_x86_64" # AL2_x86_64, AL2_x86_64_GPU, AL2_ARM_64, CUSTOM
#warm_capacity_type=  "ON_DEMAND"  # ON_DEMAND, SPOT
#warm_instance_count= 0
#warm_instance_k8s_label= {"nodetype"="warm"}
#warm_instance_type= ["r6i.4xlarge"]
#warm_max_instance_count=10
#warm_accept_ingest=true
#warm_accept_search=false


#cold_ami_type= "AL2_x86_64" # AL2_x86_64, AL2_x86_64_GPU, AL2_ARM_64, CUSTOM
#cold_capacity_type=  "ON_DEMAND"  # ON_DEMAND, SPOT
#cold_instance_count= 0
#cold_instance_k8s_label= {"nodetype"="cold"}
#cold_instance_type= ["r6i.12xlarge"]
#cold_max_instance_count=10
#cold_accept_ingest=false
#cold_accept_search=false


#frozen_ami_type= "AL2_x86_64" # AL2_x86_64, AL2_x86_64_GPU, AL2_ARM_64, CUSTOM
#frozen_capacity_type=  "ON_DEMAND"  # ON_DEMAND, SPOT
#frozen_instance_count= 0
#frozen_instance_k8s_label= {"nodetype"="frozen"}
#frozen_instance_type= ["r6i.24xlarge"]
#frozen_max_instance_count=10
#frozen_accept_ingest=false
#frozen_accept_search=false


#ml_ami_type= "AL2_x86_64" # AL2_x86_64, AL2_x86_64_GPU, AL2_ARM_64, CUSTOM
#ml_capacity_type=  "ON_DEMAND"  # ON_DEMAND, SPOT
#ml_instance_count= 0
#ml_instance_k8s_label= {"nodetype"="ml"}
#ml_instance_type= ["c6i.4xlarge"]
#ml_max_instance_count=10
#ml_accept_ingest=false
#ml_accept_search=false

#entsearch_ami_type= "AL2_ARM_64" # AL2_x86_64, AL2_x86_64_GPU, AL2_ARM_64, CUSTOM
#entsearch_capacity_type=  "ON_DEMAND"  # ON_DEMAND, SPOT
#entsearch_instance_count= 1
#entsearch_instance_k8s_label= {"nodetype"="entsearch"}
#entsearch_instance_type= ["c6g.8xlarge"]
#entsearch_max_instance_count=10
#entsearch_accept_ingest=true
#entsearch_accept_search=false

#util_ami_type= "AL2_x86_64" # AL2_x86_64, AL2_x86_64_GPU, AL2_ARM_64, CUSTOM
#util_capacity_type=  "ON_DEMAND"  # ON_DEMAND, SPOT
#util_instance_count= 1
#util_instance_k8s_label= {"nodetype"="util"}
#util_instance_type= ["t2.medium"]

#openebs_helm_chart_version="3.3.1"

#https://github.com/kubernetes/kube-state-metrics#compatibility-matrix
#ksm_helm_chart_version="4.32.0" 

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
#master_pod_storage_class = "local-storage" #valid values local-storage|master-gp3|master-io2-be
#master_pod_instance_affinity="master"


#hot_pod_ES_JAVA_OPTS= "-Xms8g -Xmx8g"
#hot_pod_count= 3
#hot_pod_cpu= "30000m"
#hot_pod_memory= "53248Mi"
#hot_pod_roles= "data_hot, data_content, ingest"
#hot_pod_storage= "1600Gi"
#hot_pod_storage_class = "local-storage" #valid values local-storage|hot-gp3|hot-io2-be
#hot_pod_storage_class_iops = 3000
#hot_pod_storage_class_throughput = 125 ##in mb
#hot_pod_instance_affinity="hot"


#warm_pod_ES_JAVA_OPTS= "-Xms8g -Xmx8g"
#warm_pod_count= 1
#warm_pod_cpu= "14000m"
#warm_pod_memory= "53248Mi"
#warm_pod_roles= "data_warm, data_content"
#warm_pod_storage= "5000Gi"
#warm_pod_storage_class = "local-storage" #valid values local-storage|warm-gp3|warm-io2-be
#warm_pod_storage_class = "gp3"
#warm_pod_storage_class_iops = 3000
#warm_pod_storage_class_throughput = 125 ##in mb
#warm_pod_instance_affinity="warm"



#cold_pod_ES_JAVA_OPTS= "-Xms8g -Xmx8g"
#cold_pod_count= 1
#cold_pod_cpu= "46000m"
#cold_pod_memory= "11264Mi"
#cold_pod_roles= "data_cold"
#cold_pod_storage= "140Gi"
#cold_pod_storage_class = "local-storage" #valid values local-storage|cold-gp3|cold-io2-be
#cold_pod_storage_class = "gp3"
#cold_pod_storage_class_iops = 3000
#cold_pod_storage_class_throughput = 125 ##in mb
#cold_pod_instance_affinity="cold"



#frozen_pod_ES_JAVA_OPTS= "-Xms8g -Xmx8g"
#frozen_pod_count= 1
#frozen_pod_cpu= "94000m"
#frozen_pod_memory= "11264Mi"
#frozen_pod_roles= "data_frozen"
#frozen_pod_storage= "140Gi"
#frozen_pod_storage_class = "local-storage" #valid values local-storage|frozen-gp3|frozen-io2-be
#frozen_pod_storage_class = "gp3"
#frozen_pod_storage_class_iops = 3000
#frozen_pod_storage_class_throughput = 125 ##in mb
#frozen_pod_instance_affinity="frozen"


#ml_pod_ES_JAVA_OPTS= "-Xms8g -Xmx8g"
#ml_pod_count= 1
#ml_pod_cpu= "14000m"
#ml_pod_memory= "11264Mi"
#ml_pod_roles= "ml, remote_cluster_client"
#ml_pod_storage= "140Gi"
#ml_pod_storage_class = "local-storage" #valid values local-storage|ml-gp3|ml-io2-be
#ml_pod_storage_class = "gp3"
#ml_pod_storage_class_iops = 3000
#ml_pod_storage_class_throughput = 125 ##in mb
#ml_pod_instance_affinity="ml"




#entsearch_pod_ES_JAVA_OPTS= "-Xms8g -Xmx8g"
#entsearch_pod_count= 1
#entsearch_pod_cpu= "30000m"
#entsearch_pod_memory= "53248Mi"
#entsearch_pod_roles= "data_entsearch, data_content, ingest"
#entsearch_pod_storage= "1600Gi"
#entsearch_pod_storage_class = "local-storage" #valid values local-storage|entsearch-gp3|entsearch-io2-be
#entsearch_pod_storage_class_iops = 3000
#entsearch_pod_storage_class_throughput = 125 ##in mb
#entsearch_pod_instance_affinity="entsearch"


#kibana_pod_count= 1
#kibana_pod_cpu= "1000m"
#kibana_pod_memory= "1Gi"
#kibana_pod_instance_affinity="kibana"

#eck_operator_instance_affinity="util"



#
#----------------------- Terraform providers ---------------------------------


#tf_aws_provider_version= "4.61.0"
#tf_k8s_provider_version = "2.16.1"
#tf_kubectl_provider_version = "1.14.0
#tf_curl_provider_version = "1.0.2"
#tf_helm_provider_version = "2.9.0"

#----------------------- istio ---------------------------------
#istio_helm_base_chart_version= "1.17.2" 
#Run this to find available versions: helm search repo istio/base --versions
#istiod_helm_chart_version=1.17.2