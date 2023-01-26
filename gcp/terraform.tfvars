####THIS section of variables are REQUIRED for 1Click Automation to run.

##your gcp cloud cli must set with your creds for the automatino to run

##house keeping tags.  Set please
tags = {
    "Owner" = "sunilemanjee"
    "KeepAliveUntil" = "12312023"
    "Project" = "1ClickECK"
    "Team" = "sa"
    "username" = "sunman" #This can be anything you call yourself
}



#######Compelete list of variables below. Uncomment and set to your liking.  The default values are table from variables.tf which should not be changed.  Override the default values here.

#project= "1ClickECK"



#gke_version="1.24.8-gke.401"
#eck_version= "2.6.1"
#es_version= "8.5.2"
#eck_namespace= "default"
#release_channel= "STABLE"

#region= "us-central1"
#zones= ["us-central1-a", "us-central1-b", "us-central1-c"]



#master_instance_count=1
#master_max_instance_count=1
#master_instance_type= "standard_D8ads_v5"
#master_instance_k8s_label= {"nodetype"="master"}
#master_volume_type= "pd-ssd"
#master_pod_count= 1
#master_pod_cpu= "6500m"
#master_pod_memory= "11264Mi"
#master_pod_storage= "140Gi"
#master_pod_ES_JAVA_OPTS= "-Xms8g -Xmx8g"
#master_pod_roles= "master"



#kibana_instance_count=2
#kibana_max_instance_count=2
#kibana_instance_type= "standard_B2ms"
#kibana_instance_k8s_label= {"nodetype"="kibana"}
#kibana_volume_type= "pd-ssd"
#kibana_capacity_type=  "ON_DEMAND"  # ON_DEMAND, SPOT
#kibana_pod_cpu= "1000m"
#kibana_pod_memory= "1Gi"
#kibana_pod_count= 1

#hot_instance_count=3
#hot_max_instance_count=3
#hot_instance_type=  "standard_D32pls_v5"
#hot_instance_k8s_label= {"nodetype"="hot"}
#hot_volume_type= "pd-ssd"
#hot_pod_count= 3
#hot_pod_cpu= "30000m"
#hot_pod_memory= "53248Mi"
#hot_pod_storage= "1600Gi"
#hot_pod_ES_JAVA_OPTS= "-Xms8g -Xmx8g"
#hot_pod_roles= "data_hot, data_content, ingest"


#warm_instance_count=0
#warm_max_instance_count=0
#warm_instance_type= "standard_E16ads_v5"
#warm_instance_k8s_label= {"nodetype"="warm"}
#warm_volume_type= "pd-ssd"
#warm_pod_count= 1
#warm_pod_cpu= "14000m"
#warm_pod_memory= "53248Mi"
#warm_pod_storage= "5000Gi"
#warm_pod_ES_JAVA_OPTS= "-Xms8g -Xmx8g"
#warm_pod_roles= "data_warm, data_content"



#cold_instance_count=0
#cold_max_instance_count=0
#cold_instance_type= "standard_E48ads_v5"
#cold_instance_k8s_label= {"nodetype"="cold"}
#cold_volume_type= "pd-ssd"
#cold_pod_count= 1
#cold_pod_cpu= "46000m"
#cold_pod_memory= "11264Mi"
#cold_pod_storage= "140Gi"
#cold_pod_ES_JAVA_OPTS= "-Xms8g -Xmx8g"
#cold_pod_roles= "data_cold"



#frozen_instance_count=0
#frozen_max_instance_count=0
#frozen_instance_type= "standard_E96ads_v5"
#frozen_instance_k8s_label= {"nodetype"="frozen"}
#frozen_volume_type= "pd-ssd"
#frozen_pod_count= 1
#frozen_pod_cpu= "94000m"
#frozen_pod_memory= "11264Mi"
#frozen_pod_storage= "140Gi"
#frozen_pod_ES_JAVA_OPTS= "-Xms8g -Xmx8g"
#frozen_pod_roles= "data_frozen"



#ml_instance_count=0
#ml_max_instance_count=0
#ml_instance_type= "standard_D16ads_v5"
#ml_instance_k8s_label= {"nodetype"="ml"}
#ml_volume_type= "pd-ssd"
#ml_pod_count= 1
#ml_pod_cpu= "14000m"
#ml_pod_memory= "11264Mi"
#ml_pod_storage= "140Gi"
#ml_pod_ES_JAVA_OPTS= "-Xms8g -Xmx8g"
#ml_pod_roles= "ml, remote_cluster_client"



#util_instance_count= 1
#util_instance_type= "standard_B2s"
#util_instance_k8s_label= {"nodetype"="util"}
#util_volume_type= "pd-ssd"


