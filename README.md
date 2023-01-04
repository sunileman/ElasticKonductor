
# 1ClickECK

1ClickECK was built to rapidly deploy with ease an AWS EKS cluster, install ECK, and the ES Stack.   

Total time from configuration to a fully launched ECK cluster generally should take less than 10 minutes.  The automation; 1ClickECK,  is idempotent.

1ClickECK currently deploys
* ElasticSearch
* Kibana
* License loading (Bring your own ES license)
* AWS ECK (Optional)

Does not deploy
* AutoScale Polices
* APM Server
* Fleet
* Elastic Maps
* Enterprise Search


 

## Prerequisites

* AWS CLI installed fully configured on the lastest version 2 release.
    * aws --version
    * aws configure
    * https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html#getting-started-install-instructions
* Install Terraform client
    * https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli
* Install kubectl client
    * https://docs.aws.amazon.com/eks/latest/userguide/install-kubectl.html
    * The version of kubectl must match the version of eks you plan on deploying.  The version number is set in terraform.tfvars, variable eks_version
* Install git client
    * To clone this repo and when possible, contribute back :)
* ElasticSearch Enterprise License
    * Only required to use enterprise features such as ML, autoscale, etc
## Deployment

Verify shell is executable.  
```bash
  chmod 700 1ClickECK.sh
```
Set a few variables
https://github.com/sunileman/1ClickEckOnEKS#terraform-variables

To create AWS EKS and ECK
```bash
  ./1ClickECK.sh -c all
```

Create all assets on your VPC and subnets. This mode requires tagging your private and public subnets
```
#Tag public subnets
tier=public

#Tag private subnets
tier=private

1ClickECK.sh -c byovpc
```

Create EKS without ECK
```
1ClickECK.sh -c eksonly
```

Create EKS without ECK on your VPC/Subnets
```
1ClickECK.sh -c byovpc-eksonly
```

To run the automation in the background.  Output will be writen to nohup.out. 
```bash
  nohup ./1ClickECK.sh -c all &
  tail -f nohup.out ##To see log output
```

Once the automation completes, Kibana endpoints along with username and password should be displayed.  To retrieve again, simply run<br>
```bash
  ./create-eck/getKibanaInfo.sh
```

The automation will set your local kubectl manifest.  Verify by running
```bash
  kubectl get nodes
```


Tear Down all assets built by the automation
```bash
  ./1ClickEckOnEKS.sh -d
```

To tear down ECK without tearing down EKS
```bash
  ./create-eck/cleanup.sh
```

If EKS is running and to redeploy ECK with new configs
```bash
  ./create-eck/1ClickECKDeploy.sh
```


## Terraform Variables

The automation requires a few variables to be set in the `./create-eks/terraform.tfvars` file<br>

Name of your deployment/project<br>
`tags.Project`<br>
Name of owner<br>
`tags.Owner`<br>
Name which will be appended to the EKS deployment<br>
`tags.username`<br>

AWS Region, ie us-east-1<br>
`region`<br>


To deploy EKS within an existing VPC, set <br>
`vpc_id`<br>
If an existing VPC will be used, create at least 2 subnets on different AZs.<br>
More about public and private subnets: https://github.com/sunileman/1ClickEckOnEKS#private-and-public-subnets


Set AWS access and secret key as envionrment variables<br>
```bash
export TF_VAR_aws_access_key="value"
export TF_VAR_aws_secret_key="value
```

Any variable found in `./create-eks/terraform.tfvars` or `./create-eks/variables.tf`
can be set as an envionrment variable. <br>
```bash
export TF_VAR_<variable name>="your value"
export TF_VAR_variable_<list variable type>='["value", "value"]'
```

Additional example on setting envionrment variables.  This method would be used
instead of defining in the `./create-eks/terraform.tfvars` file. 
```bash
export TF_VAR_vpc_id="vpc-XXXXXXX"
export TF_VAR_client_access_cidr='["000.000.00.000/32"]'
```

Envionrment variables and setting variables in terraform.tfvars can be used together. 
Consider terraform variable order of Precedence: `https://developer.hashicorp.com/terraform/language/values/variables#variable-definition-precedence`

**Note** - Instance and pod count <br>
Instance count = Number of K8s nodes per type (hot/warm/etc)) <br>
Pod count = Number of pods per type (hot/warm/etc) which will be deployed on the instance type.  <br>

For example you can 
deploy 4 hot pods on 1 hot K8s instance type.
## Private and Public Subnets
https://aws.amazon.com/blogs/containers/de-mystifying-cluster-networking-for-amazon-eks-worker-nodes/ <br>
If a subnet is associated with a route table that has a route to an internet gateway, it’s known as a public subnet. <br>
If a subnet is associated with a route table that does not have a route to an internet gateway, it’s known as a private subnet.<br>

If the public and private subnets are using during deployment
* configure public subnets routes through an internet gateay
* Configure private subnet routes through a NAT

ES assets (hot, warm, etc nodes) will be deployed in private subnets if available.

Set private subnets tag
```bash
tier=private
```

Set public subnets tag
```bash
tier=public
```
## Node Roles
Node roles are defined in `./create-eck/locals.tf` and used `create-eck/eck-elasticsearch.tf` variable `node.roles`

```
locals {
  master_pod_roles = ["master"]
  hot_pod_roles =  ["data_hot", "data_content", "ingest"]
  warm_pod_roles =  ["data_warm", "data_content"]
  cold_pod_roles =  ["data_cold" ]
  frozen_pod_roles =  ["data_frozen"]
  ml_pod_roles =  ["ml", "remote_cluster_client"]
}
```

For example. `create-eck/eck-elasticsearch.tf` defines how node roles will be applied to pods for each type
```
 "nodeSets" = [
        {
          "config" = {
            "node.roles" = local.master_pod_roles
            "transport.compress" = true
          }
...
{
          "config" = {
            "node.attr.data" = "hot"
            "node.roles" =  local.hot_pod_roles
            "transport.compress" = true
          }

```

##  Variables- Default Values
`./create-eks/variables` file host all possible variables supported by this deployment.  
If a varialble is not present in `./create-eks/terraform.tfvars`, the default value will be taken from `./create-eks/variables.tf`
If default value is not acceptable, set the varialble value in `./create-eks/terraform.tfvars`

For example, the default number of es hot instances is 3.  That default value is set in `./create-eks/variables.tf`. To 
change this value to 10; in `./create-eks/terraform.tfvars` file, set `hot_instance_count` = 10.

Another example.  The default instance type for warm is `im4gn.4xlarge`.  To change this value to
 `im4gn.8xlarge`; in `./create-eks/terraform.tfvars` file, set `warm_instance_type` = `im4gn.8xlarge`.

 Word of caution on instance types for node groups (hot, warm, etc). When selecting an instance type, verify the AMI type:  AL2_x86_64, AL2_x86_64_GPU, AL2_ARM_64.
 Instance type must fall withn specific AMI Type.  

 **Instance types <br>
 This deployment only supports **DAS, not EBS**
## Apply ES License
Deployment without a license will use a basic license configuration.  
If a ES license is available to you, place it under `./create-eck/license` and name the license file `es-license.json`.
The deployment will pick up license file 

If a license file needs to be applied or changed after deployment, simply run `./create-eck/eck-add-license.sh`
## Pod Configuration
Once EKS is deployed, ES pods will be deployed leveraging resources defined in the K8s manifest.
Each node type (master, hot, warm, ml, etc) spec is defined within `./create-eks/variables.tf`. 
Change the pod spec to your desired configuration. 

For example
```bash
ml_pod_count=value
ml_pod_cpu=value
ml_pod_memory=value
ml_pod_storage=value
ml_pod_ES_JAVA_OPTS=value
```

Latest release of ES, if jvm arguments aren't spplied for heap size, half the available memory within the pod will be used for heap. 
Take this into consideration if the defaults aren't acceptables

## Troubleshooting
```bash
1 node(s) didn't find available persistent volumes to bind
```
This means the instance type select does not have localy attached disks which is required.
Most likely the instance type choosen is EBS_ONLY.


```bash
exec plugin: invalid apiversion "client.authentication.k8s.io/v1alpha1"
```
The version of K8s does not match kubectl client.  Please refer to: https://docs.aws.amazon.com/eks/latest/userguide/install-kubectl.html

All automation logs are stored in ./logs
