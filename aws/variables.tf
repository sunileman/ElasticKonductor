variable "aws_access_key" {
  description = "AWS access key"
  type        = string
}

variable "aws_secret_key" {
  description = "AWS secret key"
  type        = string
}

variable "eks_version" {
  description = "EKS Version"
  type        = string
  default = "1.24"
}

variable "eck_version" {
  description = "ECK Version"
  type        = string
  default = "2.6.1"
}

variable "region" {
  description = "The aws region. https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-regions-availability-zones.html"
  type        = string
  default     = "us-east-1"
}

variable "availability_zones_count" {
  description = "The number of AZs."
  type        = number
  default     = 2
}

variable "project" {
  description = "ClickDeployment Name"
  type = string
  default = "1ClickECK"
}

variable "vpc_id" {
  description = "vpc to be used during eks deployment"
  type = string
  default = "NA"
}


variable "vpc_cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr_bits" {
  description = "The number of subnet bits for the CIDR. For example, specifying a value 8 for this parameter will create a CIDR with a mask of /24."
  type        = number
  default     = 8
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default = {
    "Project"     = "1ClickECK"
    "Environment" = "Development"
    "Owner"       = "someone"
    "Team"       = "someteam"
  }
}


variable "master_instance_count" {
  description = "Number of master instances"
  type        = number
  default     = 1
}

variable "master_max_instance_count" {
  description = "Max Number of master instances"
  type        = number
  default     = 2
}


variable "master_instance_type" {
  description = "Master instance type"
  type = list(string)
  default     = ["m6g.2xlarge"]
}

variable "master_instance_k8s_label" {
  description = "Master instance k8s label"
  type        = map
  default     = {"nodetype"="master"}
}

variable "master_capacity_type" {
  description = "Master capacity type"
  type = string
  default =  "ON_DEMAND"  # ON_DEMAND, SPOT
}

variable "master_ebs_volume" {
  description = "EBS Volume in GB"
  type        = number
  default     = 500
}

variable "master_ami_type" {
  description = "master AMI type"
  type = string
  default = "AL2_ARM_64" # AL2_x86_64, AL2_x86_64_GPU, AL2_ARM_64, CUSTOM
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
  type = list(string)
  default     = ["t2.medium"]
}

variable "kibana_instance_k8s_label" {
  description = "kibana instance k8s label"
  type        = map
  default     = {"nodetype"="kibana"}
}

variable "kibana_ami_type" {
  description = "kibana AMI type"
  type = string
  default = "AL2_x86_64" # AL2_x86_64, AL2_x86_64_GPU, AL2_ARM_64, CUSTOM
}

variable "kibana_capacity_type" {
  description = "hot capacity type"
  type = string
  default =  "ON_DEMAND"  # ON_DEMAND, SPOT
}

variable "kibana_ebs_volume" {
  description = "EBS Volume in GB"
  type        = number
  default     = 200
}

variable "hot_instance_count" {
  description = "Number of hot instances"
  type        = number
  default     = 3
}


variable "hot_max_instance_count" {
  description = "max Number of hot instances"
  type        = number
  default     = 10
}

variable "hot_instance_type" {
  description = "Hot instance type"
  type = list(string)
  default     = ["c6g.8xlarge"]
}

variable "hot_instance_k8s_label" {
  description = "hot instance k8s label"
  type        = map
  default     = {"nodetype"="hot"}
}

variable "hot_ami_type" {
  description = "hot AMI type"
  type = string
  default = "AL2_ARM_64" # AL2_x86_64, AL2_x86_64_GPU, AL2_ARM_64, CUSTOM
}

variable "hot_capacity_type" {
  description = "hot capacity type"
  type = string
  default =  "ON_DEMAND"  # ON_DEMAND, SPOT
}

variable "warm_instance_count" {
  description = "Number of warm instances"
  type        = number
  default     = 0
}

variable "warm_max_instance_count" {
  description = "max Number of warm instances"
  type        = number
  default     = 10
}


variable "hot_ebs_volume" {
  description = "EBS Volume in GB"
  type        = number
  default     = 2000
}

variable "warm_instance_type" {
  description = "warm instance type"
  type = list(string)
  default     = ["r6i.4xlarge"]
}

variable "warm_instance_k8s_label" {
  description = "warm instance k8s label"
  type        = map
  default     = {"nodetype"="warm"}
}

variable "warm_ami_type" {
  description = "warm AMI type"
  type = string
  default = "AL2_x86_64" # AL2_x86_64, AL2_x86_64_GPU, AL2_ARM_64, CUSTOM
}

variable "warm_capacity_type" {
  description = "warm capacity type"
  type = string
  default =  "ON_DEMAND"  # ON_DEMAND, SPOT
}

variable "warm_ebs_volume" {
  description = "EBS Volume in GB"
  type        = number
  default     = 7500
}


variable "cold_instance_count" {
  description = "Number of cold instances"
  type        = number
  default     = 0
}

variable "cold_max_instance_count" {
  description = "max number of cold instances"
  type        = number
  default     = 10
}

variable "cold_instance_type" {
  description = "Cold instance type"
  type = list(string)
  default     = ["r6i.12xlarge"]
}

variable "cold_instance_k8s_label" {
  description = "cold instance k8s label"
  type        = map
  default     = {"nodetype"="cold"}
}

variable "cold_ami_type" {
  description = "cold AMI type"
  type = string
  default = "AL2_x86_64" # AL2_x86_64, AL2_x86_64_GPU, AL2_ARM_64, CUSTOM
}


variable "cold_capacity_type" {
  description = "cold capacity type"
  type = string
  default =  "ON_DEMAND"  # ON_DEMAND, SPOT
}

variable "cold_ebs_volume" {
  description = "EBS Volume in GB"
  type        = number
  default     = 7500
}

variable "frozen_instance_count" {
  description = "Number of frozen instances"
  type        = number
  default     = 0
}

variable "frozen_max_instance_count" {
  description = "max number of frozen  instances"
  type        = number
  default     = 10
}

variable "frozen_instance_type" {
  description = "frozen instance type"
  type = list(string)
  default     = ["r6i.24xlarge"]
}

variable "frozen_instance_k8s_label" {
  description = "frozen instance k8s label"
  type        = map
  default     = {"nodetype"="frozen"}
}

variable "frozen_ami_type" {
  description = "frozen AMI type"
  type = string
  default = "AL2_x86_64" # AL2_x86_64, AL2_x86_64_GPU, AL2_ARM_64, CUSTOM
}


variable "frozen_capacity_type" {
  description = "frozen capacity type"
  type = string
  default =  "ON_DEMAND"  # ON_DEMAND, SPOT
}

variable "frozen_ebs_volume" {
  description = "EBS Volume in GB"
  type        = number
  default     = 7500
}

variable "ml_instance_count" {
  description = "Number of ml instances"
  type        = number
  default     = 0
}

variable "ml_max_instance_count" {
  description = "max number of ml instances"
  type        = number
  default     = 10
}

variable "ml_instance_type" {
  description = "ML instance type"
  type = list(string)
  default     = ["c6i.4xlarge"]
}

variable "ml_instance_k8s_label" {
  description = "ml instance k8s label"
  type        = map
  default     = {"nodetype"="ml"}
}

variable "ml_ami_type" {
  description = "AMI type"
  type = string
  default = "AL2_x86_64" # AL2_x86_64, AL2_x86_64_GPU, AL2_ARM_64, CUSTOM
}


variable "ml_capacity_type" {
  description = "ml capacity type"
  type = string
  default =  "ON_DEMAND"  # ON_DEMAND, SPOT
}

variable "ml_ebs_volume" {
  description = "EBS Volume in GB"
  type        = number
  default     = 950
}

variable "util_instance_count" {
  description = "Number of util instances"
  type        = number
  default     = 1
}

variable "util_instance_type" {
  description = "util instance type"
  type = list(string)
  default     = ["t2.medium"]
}

variable "util_instance_k8s_label" {
  description = "util instance k8s label"
  type        = map
  default     = {"nodetype"="util"}
}

variable "util_capacity_type" {
  description = "util capacity type"
  type = string
  default =  "ON_DEMAND"  # ON_DEMAND, SPOT
}

variable "util_ami_type" {
  description = "util node AMI type"
  type = string
  default = "AL2_x86_64" # AL2_x86_64, AL2_x86_64_GPU, AL2_ARM_64, CUSTOM
}

variable "util_ebs_volume" {
  description = "EBS Volume in GB"
  type        = number
  default     = 200
}


variable "client_access_cidr" {
  description = "client access cidr to include in security group access clearnance"
  type = list(string)
  default = ["0.0.0.0/0"]
}

variable "endpoint_private_access" {
  description = "enable private access endpoint"
  type = string
  default = "false"
}

variable "endpoint_public_access" {
  description = "enable public lccess endpoint"
  type = string
  default = "true"
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

