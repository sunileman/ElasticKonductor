tags = {
    "division" = "field"
    "org" = "sa"
    "team" = "amer"
    "project" = "username" # Project name (shared) or username (individual)
    "enddate" = "05012024" #MMDDYYYY
}

region= "us-east-1"

master_instance_type= ["m6g.xlarge"]
master_instance_count = 1
kibana_instance_count = 0
hot_instance_count = 0
entsearch_instance_count = 0
util_instance_count = 0

master_pod_count = 1
master_pod_cpu = "1000m"
master_pod_memory = "2000Mi"
master_pod_roles = "master, data_hot, data_content, ingest"
master_pod_storage_class = "gp2"

hot_pod_count = 1
hot_pod_cpu = "1000m"
hot_pod_memory = "2000Mi"
hot_pod_instance_affinity="master"
hot_pod_storage_class = "gp2"

kibana_pod_count = 1
kibana_pod_cpu = "500m"
kibana_pod_memory = "500Mi"
kibana_pod_instance_affinity="master"

entsearch_pod_count = 0

eck_operator_instance_affinity="master"
