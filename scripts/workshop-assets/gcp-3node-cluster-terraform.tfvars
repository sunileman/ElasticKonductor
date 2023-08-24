tags = {
    "division" = "field"
    "org" = "sa"
    "team" = "amer"
    "project" = "username" # Project name (shared) or username (individual)
}


region= "us-central1"
zones= ["us-central1-a"]

gcp_project="elastic-sa"


#K8s Node specs
master_instance_type= "e2-standard-2"
hot_instance_type= "e2-standard-2"
kibana_instance_type= "e2-standard-2"
entsearch_instance_count = 0

#ES Pod specs
entsearch_pod_count = 0

master_pod_count= 1
master_pod_cpu= "500m"
master_pod_memory= "4Gi"
master_pod_storage= "500Gi"

hot_pod_count= 1
hot_pod_cpu= "500m"
hot_pod_memory= "4Gi"
hot_pod_storage= "500Gi"


kibana_pod_cpu = "200m"
kibana_pod_memory = "1Gi"
