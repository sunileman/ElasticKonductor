
# 1ClickECK

1ClickECK was built to rapidly deploy with ease an K8s (AWS EKS/Azure AKS) cluster, install ECK, and the ES Stack.   

Total time from configuration to a fully launched ECK cluster generally should take less than 10 minutes.  The automation; 1ClickECK,  is idempotent.

1ClickECK currently deploys
* EKS or AKS
* ECK (Optional)
    * ElasticSearch 
    * Kibana
    * License loading (Bring your own ES license)

Does not deploy
* APM Server
* Fleet
* Elastic Maps
* Enterprise Search


 

## Prerequisites

`General`
* Install Terraform client
    * https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli
* Install kubectl client
    * https://docs.aws.amazon.com/eks/latest/userguide/install-kubectl.html
    * The version of kubectl must match the version of eks/aks you plan on deploying.  The version number is set in terraform.tfvars, variable eks_version/aks_version
* Install git client
    * To clone this repo and when possible, contribute back :)
* ElasticSearch Enterprise License
    * Only required to use enterprise features such as ML, autoscale, etc

`AWS`
* AWS CLI installed fully configured on the lastest version 2 release.
    * aws --version
    * aws configure
    * https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html#getting-started-install-instructions



`Azure`
* AZ CLI CLI installed fully configured
    * https://learn.microsoft.com/en-us/cli/azure/install-azure-cli
* Azure service principal
    * https://learn.microsoft.com/en-us/azure/developer/terraform/authenticate-to-azure?tabs=bash#create-a-service-principal
    * Make note of the `appId`, `display_name`, `password`, and `tenantID`
* Set the following env variables
```
export ARM_CLIENT_ID="Your appID"
export ARM_CLIENT_SECRET="Your app secret"
export ARM_SUBSCRIPTION_ID="Your Azure SUBSCRIPTION"
export ARM_TENANT_ID="Your tenantID"
export TF_VAR_aks_service_principal_app_id="Your appID"
export TF_VAR_aks_service_principal_client_secret="Your app secret"
```
## Deployment

Set a few variables to name your deployment

AWS

`./aws/terraform.tfvars`

Azure 

`./azure/terraform.tfvars`
```
tags = {
    "Owner" = "your email"
    "username" = "superman" #Naming your deployment
}
```
Required Arguments 

-c [aws|azure]

-b [all|k8s]

-d <Destroy all assets created by the automation>

Examples

To create AWS EKS and ECK
```bash
  ./1ClickECK.sh -b all -c aws
```

To create EKS
```bash
  ./1ClickECK.sh -b k8s -c aws
```

To create AKS and ECK
```bash
  ./1ClickECK.sh -b all -c azure
```

To create AKS
```bash
  ./1ClickECK.sh -b k8s -c azure
```

To run the automation in the background.  Output will be writen to nohup.out. 
```bash
  nohup ./1ClickECK.sh -b all -c aws &
```

Once the automation completes, Kibana endpoints along with username and password should be displayed.  To retrieve again, simply run<br>
```bash
  ./[aws|azure]/create-eck/getClusterInfo.sh
```

The automation will set your local kubectl manifest.  Verify by running
```bash
  kubectl get nodes
```


Tear Down all assets built by the automation
```bash
  ./1ClickEckOnEKS.sh -d -c aws
```


## Terraform Variables

The automation requires a few variables to be set in the `.[aws|azure]/terraform.tfvars` file<br>

Name of your deployment/project<br>
`tags.Project`<br>
Name of owner<br>
`tags.Owner`<br>
Name which will be appended to the EKS deployment<br>
`tags.username`<br>


Any variable found in `./[aws|azure]/variables.tf` can be set as an envionrment variable. <br>
```bash
export TF_VAR_<variable name>="your value"
export TF_VAR_variable_<list variable type>='["value", "value"]'
```

Envionrment variables and setting variables in terraform.tfvars can be used together. 
Consider terraform variable order of Precedence: `https://developer.hashicorp.com/terraform/language/values/variables#variable-definition-precedence`

**Note** - Instance and pod count <br>
Instance count = Number of K8s nodes per type (hot/warm/etc)) <br>
Pod count = Number of pods per type (hot/warm/etc) which will be deployed on the instance type.  <br>

For example you can 
deploy 4 hot pods on 1 hot K8s instance type.
##  Variables- Default Values
`./[aws|azure]/variables` file host all possible variables supported by this deployment.  
If a varialble is not present in `./[aws|azure]/terraform.tfvars`, the default value will be taken from `./[aws|azure]/variables.tf`
If default value is not acceptable, set the varialble value in `./[aws|azure]/terraform.tfvars`

For example, the default number of es hot instances is 3.  That default value is set in `./[aws|azure]/variables.tf`. To 
change this value to 10; in `./[aws|azure]/terraform.tfvars` file, set `hot_instance_count` = 10.

Another example.  The default instance type for warm is `im4gn.4xlarge`.  To change this value to
 `im4gn.8xlarge`; in `./[aws|azure]/terraform.tfvars` file, set `warm_instance_type` = `im4gn.8xlarge`.

 Word of caution on instance types for node groups (hot, warm, etc). When selecting an instance type, verify the AMI type:  AL2_x86_64, AL2_x86_64_GPU, AL2_ARM_64.
 Instance type must fall withn specific AMI Type.  

 **Instance types <br>
 This deployment only supports **DAS, not EBS**
## Apply ES License
Deployment without a license will use a basic license configuration.  
If a ES license is available to you, place it under `./[aws|azure]/create-eck/license` and name the license file `es-license.json`.
The deployment will pick up license file 

If a license file needs to be applied or changed after deployment, simply run `./[aws|azure]/create-eck/eck-add-license.sh`
## Pod Configuration
Once EKS is deployed, ES pods will be deployed leveraging resources defined in the K8s manifest.
Each node type (master, hot, warm, ml, etc) spec is defined within `./[aws|azure]/variables.tf`. 
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

## ECK/ES Updates
The automation; 1ClickECK,  is idempotent.  Therefore if updates to ECK or ES have been applied, simple rerun 1ClickECK with the same -b -c arguments 
## kubectl manifest
Automation will set local kube config (kubectl) after automation run.  If local kube config needs to be reset, simple rerun the automation (even if there is no change) to set local kube config.
## Troubleshooting
```bash
OOMKilled
```
Pod JVM is requesting more memory than pod limits


```bash
exec plugin: invalid apiversion "client.authentication.k8s.io/v1alpha1"
```
The version of K8s does not match kubectl client.  Please refer to: https://docs.aws.amazon.com/eks/latest/userguide/install-kubectl.html

All automation logs are stored in ./logs


```bash
Error: Kubernetes cluster unreachable: invalid configuration: no configuration has been provided, try setting KUBERNETES_MASTER environment variable
```
try:  export KUBE_CONFIG_PATH=~/.kube/config
