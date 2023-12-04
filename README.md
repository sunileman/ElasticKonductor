
# ElasticKonductor

ElasticKonductor was built to rapidly deploy with ease an K8s (AWS EKS/Azure AKS/GCP GKE) cluster, install ECK, and the ES Stack.   

Total time from configuration to a fully launched ECK cluster generally should take less than 10 minutes.  The automation; ElasticKonductor,  is idempotent.

Note - Automation deploys OpenEBS which exposes and uses locally attached storage. More info, go to the OpenEBS section

ElasticKonductor currently deploys
* EKS, AKS, GKE
* ECK (Optional)
    * ElasticSearch 
    * Kibana
    * License loading (Bring your own ES license)
* OpenTelemetry Demo (AKS,GKE)
* Enterprise Search
* ElasticSearch Service (ESS)
* Istio

Does not deploy
* APM Server
* Fleet
* Elastic Maps

[![2023-06-28-21-54-31.jpg](https://i.postimg.cc/pd5qQBNj/2023-06-28-21-54-31.jpg)](https://postimg.cc/Z9Z84p5Y)




## Prerequisites


`Quick Start`
Details regarding clients required to run the automtaion are outlined in the following sections.  However if a ubuntu 20.+ instance is available, a quick start client install script is available here 
`https://github.com/sunileman/ElasticKonductor/blob/main/scripts/ElasticKonductor-client-install.sh`
This will install all the required libaries and CLIs for the automation. 


`General`
* Ubuntu host to install all clients listed below (terraform, aws cli, etc).  Automation has been tested on ONLY on Ubuntu x86 host as root user
* Install Terraform client
    * https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli
* Install kubectl client
    * AWS
        * https://docs.aws.amazon.com/eks/latest/userguide/install-kubectl.html
        * The version of kubectl must match the version of eks/aks you plan on deploying.  The version number is set in terraform.tfvars, variable eks_version/aks_version
    * GCP
        * https://cloud.google.com/kubernetes-engine/docs/how-to/cluster-access-for-kubectl#gcloud
* Install git client
    * To clone this repo and when possible, contribute back :)
* ElasticSearch Enterprise License
    * Only required to use enterprise features such as ML, autoscale, etc

`AWS`
* AWS CLI installed fully configured on the lastest version 2 release.
    * aws --version
    * aws configure
    * https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html#getting-started-install-instructions

`GIT`
* Not required.  If interested in pulling the repo via ssh to keep up with updates applied to this automation
`https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent`


`Azure`
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
* AZ CLI CLI installed fully configured
    * https://learn.microsoft.com/en-us/cli/azure/install-azure-cli
    * run az login with your creds
    * `az login --service-principal -u $ARM_CLIENT_ID -p $ARM_CLIENT_SECRET --tenant $ARM_TENANT_ID`

* `GCP`
    * https://cloud.google.com/kubernetes-engine/docs/how-to/cluster-access-for-kubectl#gcloud
    * run `gcloud init` to initialize your client
    * run `gcloud auth application-default login`
    * Note - project must be set in terraform.tfvars.  Project value within tags variable is used to tag instances with project value.  Not the same as gcp project which is set in terrform.tfvars.
    * To set your gcp project, run `export TF_VAR_gcp_project="your-project-name"`
## Deployment

[![2023-06-28-22-08-23.jpg](https://i.postimg.cc/c17ggtzL/2023-06-28-22-08-23.jpg)](https://postimg.cc/7b6YjhDF)


[![2023-02-07-15-29-55.jpg](https://i.postimg.cc/BbsnTdYq/2023-02-07-15-29-55.jpg)](https://postimg.cc/qhbr0ZHY)

`Note`: The automation requires `tags.project` variable to be set in the `.[aws|azure]/terraform.tfvars`.  Set the variable with your username, no special characters. Keep it short



#### Required Arguments

`-c` [aws|azure|gcp|ess]

`-b` [all|k8s|eck|otel] 

`-d` Destroy all assets created by the automation

`-r` disable openebs

`de` destroy ECK

`do` destroy Open Telemetry

`i` get cluster info 

`int` get cluster infra info 

**Note**
`-b eck` option assumes K8s has been deployed

Examples

[![2023-06-28-22-01-40.jpg](https://i.postimg.cc/7LzjP4Zj/2023-06-28-22-01-40.jpg)](https://postimg.cc/Ff9TG2cx)

To run the automation in the background.  Output will be writen to nohup.out. 
```bash
  nohup ./elastickonductor.sh -b all -c [aws|gcp|azure] &
```

Once the automation completes, Kibana endpoints along with username and password should be displayed.  


The automation will set your local kubectl manifest.  Verify by running
```bash
  kubectl get nodes
```


Tear Down all assets built by the automation
```bash
  ./elastickonductor.sh -d -c [aws|gcp|azure]
```

#### Retrieve Kibana/ES URL and username & password
`./elastickonductor.sh -c [aws|gcp|azure] -i`

## Enterprise Search
By default enterprise search is deployed with Konductor.  To deploy additonal enterprise search pods or K8s nodes set the following variables in `terraform.tfvars`

```
entsearch_pod_count= 1
entsearch_instance_count= 1
```
To remove enterprise search, simply set both variables to `0`. 

## ElasticSearch Service (ESS)
To deploy ESS set variables in `terraform.tfvars` under the folder `ess`.  Additinoal set your ESS api key via environment variables 
`export EC_API_KEY="your ess api key"`

To deploy ESS
`./elastickonductor.sh -c ess -b all`

ESS username/password will be displayed via stdout once deployment completes.  To retrieve username/password
`.elastickonductor.sh -c ess -i`


To destroy ESS
`.elastickonductor.sh -c ess -d`


## Open Telemetry
The automation also has the ability to launch the Open Telemetry Demo found here: `https://opentelemetry.io/docs/demo/kubernetes-deployment/`

Use `-b otel` during the launch process

The demo can send data to ElasticSearch by setting the following env variables

```
export TF_VAR_es_apm_url="https://xxxxxx.elastic-cloud.com:443"

export TF_VAR_es_apm_token="xxxxxx"
```

To destroy/tear down Open Telemetry Demo 
`./elastickonductor.sh -c azure -do`

####  Open Telemetry UI
Once Otel demo has been deployed, the UI will be available on port `8080` via cloud native load balancer.

To retrieve the load balancer IP, run
```
kubectl get service open-telemetry-frontendproxy
```
That will return something similar to this
```
NAME                           TYPE           CLUSTER-IP   EXTERNAL-IP     PORT(S)          AGE
open-telemetry-frontendproxy   LoadBalancer   10.52.5.6    30.300.30.300   8080:30658/TCP   32m
```

Using the external IP (The example returned `30.300.30.300`), otel demo UI will be availale at `30.300.30.300:8080`.  Please replace `30.300.30.300` with your external IP.

#### GCP Open Telemetry Demo 
Example `terraform.tfvars`  to run  Open Telemetry Demo  on GCP
```
tags = {
    "division" = "field"
    "org" = "sa"
    "team" = "amer"
    "project" = "superman"
}


region= "us-central1"
zones= ["us-central1-a", "us-central1-b", "us-central1-c"]

gcp_project="your-gcp-project"

otel_instance_count= 1

master_initial_node_count_per_zone=0
hot_initial_node_count_per_zone=0
warm_initial_node_count_per_zone=0
cold_initial_node_count_per_zone=0
frozen_instance_count_per_zone=0
ml_initial_node_count_per_zone=0
entsearch_instance_count = 0
util_instance_count=0
kibana_instance_count=0
fleet_instance_count=0


es_apm_url= "your-es-apm.elastic-cloud.com:443" #without https:// prefix
es_apm_token="your es apm token" #your Elastic APM secret token


```
#### Azure Open Telemetry Demo 

```
tags = {
    "division" = "field"
    "org" = "sa"
    "team" = "amer"
    "project" = "superman" # Project name (shared) or username (individual)
}

resource_group_location="eastus"


otel_instance_count= 1

master_instance_count=0
hot_instance_count=0
kibana_instance_count=0
warm_instance_count=0
cold_instance_count=0
frozen_instance_count=0
ml_instance_count=0
entsearch_instance_count=0



es_apm_url= "your-es-apm.elastic-cloud.com:443" #without https:// prefix
es_apm_token="your es apm token" #your Elastic APM secret token

```




## Autoscaling
[![2023-01-30-11-26-51.jpg](https://i.postimg.cc/HszXV6xj/2023-01-30-11-26-51.jpg)](https://postimg.cc/HVJVN4bC)
## Terraform Variables

Any variable found in `./[aws|azure]/variables.tf` can be set as an envionrment variable. <br>
```bash
export TF_VAR_<variable name>="your value"
export TF_VAR_variable_<list variable type>='["value", "value"]'
```

Envionrment variables and setting variables in terraform.tfvars can be used together. 
Consider terraform variable order of Precedence: `https://developer.hashicorp.com/terraform/language/values/variables#variable-definition-precedence`

**Note** Refrain from altering the region and/or zone in conjunction with the -d option. Doing so prompts the automation to attempt the destruction of assets in the modified region that may not be present. First, employ the -d option to dismantle assets, and subsequently, modify the region/zone.

**Note** - Instance and pod count <br>
Instance count = Number of K8s nodes per type (hot/warm/etc)) <br>
Pod count = Number of pods per type (hot/warm/etc) which will be deployed on the instance type.  <br>

For example you can 
deploy 4 hot pods on 1 hot K8s instance type.
##  Variables- Default Values
[![2023-02-07-15-31-29.jpg](https://i.postimg.cc/nLZSt2PX/2023-02-07-15-31-29.jpg)](https://postimg.cc/v4qtrrMy)
`./[aws|azure]/variables` file host all possible variables supported by this deployment.  
If a varialble is not present in `./[aws|azure]/terraform.tfvars`, the default value will be taken from `./[aws|azure]/variables.tf`
If default value is not acceptable, set the varialble value in `./[aws|azure|gcp]/terraform.tfvars`

For example, the default number of es hot instances is 3.  That default value is set in `./[aws|azure]/variables.tf`. To 
change this value to 10; in `./[aws|azure]/terraform.tfvars` file, set `hot_instance_count` = 10.

Another example.  The default instance type for warm is `im4gn.4xlarge`.  To change this value to
 `im4gn.8xlarge`; in `./[aws|azure]/terraform.tfvars` file, set `warm_instance_type` = `im4gn.8xlarge`.

 Word of caution on instance types for node groups (hot, warm, etc). When selecting an instance type, verify the AMI type:  AL2_x86_64, AL2_x86_64_GPU, AL2_ARM_64.
 Instance type must fall withn specific AMI Type.  

 **Instance types <br>
 This deployment only supports **DAS, not EBS**


Ingest to pods are set by the following variables
`[master|hot|warm|cold|frozen|ml]_accept_ingest=false`

GCP - To skip node pool creation
`[master|hot|warm|cold|frozen|ml]_create_node_pool=false`
## Apply ES License
Deployment without a license will use a basic license configuration.  
If a ES license is available to you, place it under `./[aws|azure|gcp]/create-eck/license` and name the license file `es-license.json`.
The deployment will pick up license file 

If a license file needs to be applied or changed after deployment, simply run `./[aws|azure|gpc]/create-eck/eck-add-license.sh`
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

## Storage Class
By default ECK will mount local storage class to ES pods.  To use a different storage class is simple.  It is important to note that if network/remote storage will be used instead of local storage, use the `-r`.  For example `./elastickonductor.sh -c gcp -b all -r`

Run `kubeclt get sc` to retrieve available storage classes.  

GKE
`[master|hot|warm|cold|frozen|ml]_pod_storage_class = "premium-rwo"`

AWS
To use gp3 or io2-be set the following
`hot_pod_storage_class = "hot-gp3" #valid values local-storage|hot-gp3|hot-io2-be
`hot_pod_storage_class_iops = "3000"`
`hot_pod_storage_class_throughput = "125" ##in mb`


Azure
`[master|hot|warm|cold|frozen|ml]_pod_storage_class = "managed-csi-premium"`

Run the automation with `r` option to disable openebs

## Kube State Metrics (KSM)
ElasticKonductor installs KSM by default with the service name `ksm-kube-state-metrics`. Under the kube-state-metrics integration section for Kubernetes, update the service name to `ksm-kube-state-metrics.kube-system.svc.cluster.local` with port `8080`.

## ECK/ES Updates
The automation; ElasticKonductor,  is idempotent.  Therefore if updates to ECK or ES have been applied, simple rerun ElasticKonductor with the same -b -c arguments 
## kubectl manifest
Automation will set local kube config (kubectl) after automation run.  If local kube config needs to be reset, simple rerun the automation (even if there is no change) to set local kube config.

To reset your local kubeclt, run
```bash
  /ElasticKonductor/[gpc|aws|azure]/create-[eks|aks|gke]/setkubectl.sh
```
## OpenEBS / Local Storage
OpenEBS is a automatic local disk provisioner for K8s.  There may be scanerios (ie using network storage) the defaults from OpenEBS are not useful. To handle these scanerios, run the automation with `-r` option to disable openEBS

```
./elastickonductor.sh -c gcp -b k8s -r
```

## Troubleshooting

Azure AKS bash into pod
`https://learn.microsoft.com/en-us/azure/aks/node-access`

GCP GKE bash into pod
`https://cloud.google.com/migrate/containers/docs/troubleshooting/executing-shell-commands`

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



If one of the pods is stuck in `init` stage run
```
kubectl describe pod <podname>
```
That should give you an idea on what went wrong.  If the mount fails due to `srv/local` not available, rerun openEBS.  


How to enter pod within GKE nodes
```
gcloud compute ssh <NODE_NAME> --zone <ZONE>
```




-Logs showing markup
Use lnav to view logs: https://lnav.org/


Azure Error
``` 
Error: building AzureRM Client: Authenticating using the Azure CLI is only supported as a User (not a Service Principal).
```
Set your azure creds prior to launching the automation


-Connection refused when trying to reach ES API port 9200
Verify at least 1 pod has role which does inclue master.  The load balancer deployed selects nodes based on
`elasticsearch.k8s.elastic.co/node-master: "false"`


Error
```
│ Error: Failed to query available provider packages
│ 
│ Could not retrieve the list of available versions for provider
│ anschoewe/curl: could not connect to registry.terraform.io: Failed to
│ request discovery document: Get
│ "https://registry.terraform.io/.well-known/terraform.json": read tcp
│ xxxx:54284->xxxx:443: read: connection reset by peer
```
Rerun automation.  Terraform api (target side) was reset.  


Error
```
An error occurred (UnrecognizedClientException) when calling the DescribeCluster operation: The security token included in the request is invalid.
```

Try: aws creds are invalid.  Verify by running
`aws sts get-caller-identity`

Error
```
Error: Get "https://oneclickeck-eyawmryu.hcp.eastus.azmk8s.io:443/api/v1/namespaces/kube-system/services/ksm-kube-state-metrics": dial tcp 40.88.241.57:443: connect: connection refused - error from a previous attempt: read tcp 10.0.9.248:46760->40.88.241.57:443: read: connection reset by peer
│ 
│   with helm_release.ksm,
│   on ksm.tf line 1, in resource "helm_release" "ksm":
│    1: resource "helm_release" "ksm" {
 ```
Rerun the automation


Otel helm fails to installs
```
│ Warning: Helm release "open-telemetry" was created but has a failed status. Use the `helm` command to investigate the error, correct it, then run Terraform again.
│ 
│   with helm_release.otel,
│   on otel.tf line 1, in resource "helm_release" "otel":
│    1: resource "helm_release" "otel" {
│ 
╵
╷
│ Error: Get "https://xxxx/api/v1/namespaces/default/services/open-telemetry-loadgenerator": dial tcp xxx:443: connect: connection refused
│ 
│   with helm_release.otel,
│   on otel.tf line 1, in resource "helm_release" "otel":
│    1: resource "helm_release" "otel" {

set `otel_instance_count` to a value `> 0`  in terraform.tfvars as otel pods are created in the otel k8s node group


Error `Failed to install provider`
```
╷
│ Error: Failed to install provider
│ 
│ Error while installing hashicorp/google v4.50.0: releases.hashicorp.com:
│ Get
│ "https://releases.hashicorp.com/terraform-provider-google/4.50.0/terraform-provider-google_4.50.0_linux_amd64.zip":
│ net/http: TLS handshake timeout
╵
```



Error with kubectl
```kubectl get nodes
 couldn't get current server API group list: Get "http://localhost:8080/api?timeout=32s": dial tcp 127.0.0.1:8080: connect: connection refused
```
Run `./elastickonductor.sh -c <gcp|azure|aws> -k` to set your local kubectl config


Error with aws destroy or create
```
An error occurred (AccessDeniedException) when calling the DescribeCluster operation: User: arn:aws:sts::xxx:assumed-role/AmazonSSMRoleForInstancesQuickSetup/xxxxx is not authorized to perform: eks:DescribeCluster on resource: arn:aws:eks:us-east-1:xxxx:cluster/1ClickECK-sunman-tolerant-seagull
```
Run `aws configure`.  This is required prior to running konductor