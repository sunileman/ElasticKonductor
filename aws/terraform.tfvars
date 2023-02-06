####THIS section of variables are REQUIRED for 1Click Automation to run.

##house keeping tags.  Set please
tags = {
    "Division" = "field"
    "Org" = "sa"
    "Team" = "amer"
    "Project" = "sunman" # Project name (shared) or username (individual)
}

####Set aws creds here or as env variables which is more secure#### 
#aws_access_key="your-key"
#aws_access_key="your-key"

##or set as env varialbles 

#export TF_VAR_aws_secret_key="your-secret"
#export TF_VAR_aws_secret_key="your-secret"

master_instance_type=["m6g.4xlarge"]

region="us-west-1"


#######Compelete list of variables below. Uncomment and set to your liking.  The default values are table from variables.tf which should not be changed.  Override the default values here.


#project= "1ClickECK"

#aws_access_key
#aws_secret_key

#eks_version="1.24"


#eck_version= "2.6.1"
#es_version= "8.5.2"
#eck_namespace= "default"


#region= "us-east-1"
#availability_zones_count= 2
#client_access_cidr= ["0.0.0.0/0"]
#endpoint_private_access= "false"
#endpoint_public_access= "true"



#master_instance_count=1
#master_max_instance_count=2
#master_instance_type= ["m6g.2xlarge"]
#master_instance_k8s_label= {"nodetype"="master"}
#master_capacity_type="ON_DEMAND"  # ON_DEMAND, SPOT
#master_ebs_volume= 500
#master_ami_type= "AL2_ARM_64" # AL2_x86_64, AL2_x86_64_GPU, AL2_ARM_64, CUSTOM
#master_pod_count= 1
#master_pod_cpu= "6500m"
#master_pod_memory= "11264Mi"
#master_pod_storage= "140Gi"
#master_pod_ES_JAVA_OPTS= "-Xms8g -Xmx8g"
#master_pod_roles= "master"



#kibana_instance_count= 2
#kibana_max_instance_count=10
#kibana_instance_type= ["t2.medium"]
#kibana_instance_k8s_label= {"nodetype"="kibana"}
#kibana_ami_type= "AL2_x86_64" # AL2_x86_64, AL2_x86_64_GPU, AL2_ARM_64, CUSTOM
#kibana_capacity_type=  "ON_DEMAND"  # ON_DEMAND, SPOT
#kibana_ebs_volume= 200
#kibana_pod_cpu= "1000m"
#kibana_pod_memory= "1Gi"
#kibana_pod_count= 1

#hot_instance_count= 3
#hot_max_instance_count=10
#hot_instance_type= ["c6g.8xlarge"]
#hot_instance_k8s_label= {"nodetype"="hot"}
#hot_ami_type= "AL2_ARM_64" # AL2_x86_64, AL2_x86_64_GPU, AL2_ARM_64, CUSTOM
#hot_capacity_type=  "ON_DEMAND"  # ON_DEMAND, SPOT
#hot_ebs_volume= 2000
#hot_pod_count= 3
#hot_pod_cpu= "30000m"
#hot_pod_memory= "53248Mi"
#hot_pod_storage= "1600Gi"
#hot_pod_ES_JAVA_OPTS= "-Xms8g -Xmx8g"
#hot_pod_roles= "data_hot, data_content, ingest"


#warm_instance_count= 0
#warm_max_instance_count=10
#warm_instance_type= ["r6i.4xlarge"]
#warm_instance_k8s_label= {"nodetype"="warm"}
#warm_ami_type= "AL2_x86_64" # AL2_x86_64, AL2_x86_64_GPU, AL2_ARM_64, CUSTOM
#warm_capacity_type=  "ON_DEMAND"  # ON_DEMAND, SPOT
#warm_ebs_volume= 7500
#warm_pod_count= 1
#warm_pod_cpu= "14000m"
#warm_pod_memory= "53248Mi"
#warm_pod_storage= "5000Gi"
#warm_pod_ES_JAVA_OPTS= "-Xms8g -Xmx8g"
#warm_pod_roles= "data_warm, data_content"



#cold_instance_count= 0
#cold_max_instance_count=10
#cold_instance_type= ["r6i.12xlarge"]
#cold_instance_k8s_label= {"nodetype"="cold"}
#cold_ami_type= "AL2_x86_64" # AL2_x86_64, AL2_x86_64_GPU, AL2_ARM_64, CUSTOM
#cold_capacity_type=  "ON_DEMAND"  # ON_DEMAND, SPOT
#cold_ebs_volume= 750
#cold_pod_count= 1
#cold_pod_cpu= "46000m"
#cold_pod_memory= "11264Mi"
#cold_pod_storage= "140Gi"
#cold_pod_ES_JAVA_OPTS= "-Xms8g -Xmx8g"
#cold_pod_roles= "data_cold"



#frozen_instance_count= 0
#frozen_max_instance_count=10
#frozen_instance_type= ["r6i.24xlarge"]
#frozen_instance_k8s_label= {"nodetype"="frozen"}
#frozen_ami_type= "AL2_x86_64" # AL2_x86_64, AL2_x86_64_GPU, AL2_ARM_64, CUSTOM
#frozen_capacity_type=  "ON_DEMAND"  # ON_DEMAND, SPOT
#frozen_ebs_volume= 7500
#frozen_pod_count= 1
#frozen_pod_cpu= "94000m"
#frozen_pod_memory= "11264Mi"
#frozen_pod_storage= "140Gi"
#frozen_pod_ES_JAVA_OPTS= "-Xms8g -Xmx8g"
#frozen_pod_roles= "data_frozen"



#ml_instance_count= 0
#ml_max_instance_count=10
#ml_instance_type= ["c6i.4xlarge"]
#ml_instance_k8s_label= {"nodetype"="ml"}
#ml_ami_type= "AL2_x86_64" # AL2_x86_64, AL2_x86_64_GPU, AL2_ARM_64, CUSTOM
#ml_capacity_type=  "ON_DEMAND"  # ON_DEMAND, SPOT
#ml_ebs_volume= 950
#ml_pod_count= 1
#ml_pod_cpu= "14000m"
#ml_pod_memory= "11264Mi"
#ml_pod_storage= "140Gi"
#ml_pod_ES_JAVA_OPTS= "-Xms8g -Xmx8g"
#ml_pod_roles= "ml, remote_cluster_client"



#util_instance_count= 1
#util_instance_type= ["t2.medium"]
#util_instance_k8s_label= {"nodetype"="util"}
#util_capacity_type=  "ON_DEMAND"  # ON_DEMAND, SPOT
#util_ami_type= "AL2_x86_64" # AL2_x86_64, AL2_x86_64_GPU, AL2_ARM_64, CUSTOM
#util_ebs_volume= 200


