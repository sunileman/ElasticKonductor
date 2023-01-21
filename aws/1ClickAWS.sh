#!/bin/bash
$(mkdir ./logs 2>/dev/null)
LOG_LOCATION=./logs
exec > >(tee -i $LOG_LOCATION/1Click.log)
exec 2>&1

echo "Log Location should be: [ $LOG_LOCATION ]"

usage() {
     echo "Usage: $0 [-b <all | byovpc | eks | byovpc-eks>] [-d for destroy] [-h for help]."
     echo "Hit enter to try again with correct arguments"
     exit 0;
}

cleanup() {
  createmode=false
  eksonly=false
  destroy=false
  createModeArg=NA
}

resetTFs(){
  $(mv ./create-eks/data-sources.tf ./create-eks/data-sources.not-in-use 2>/dev/null)
  $(mv ./create-eks/worker-nodes.tf ./create-eks/worker-nodes.not-in-use 2>/dev/null)
  $(mv ./create-eks/eks-cluster.tf ./create-eks/eks-cluster.not-in-use 2>/dev/null)
  $(mv ./create-eks/vpc.tf ./create-eks/vpc.not-in-use 2>/dev/null)
  $(mv ./create-eks/data-sources-byovpc.tf ./create-eks/data-sources-byovpc.not-in-use 2>/dev/null)
  $(mv ./create-eks/worker-nodes-byovpc.tf ./create-eks/worker-nodes-byovpc.not-in-use 2>/dev/null)
  $(mv ./create-eks/eks-cluster-byovpc.tf ./create-eks/eks-cluster-byovpc.not-in-use 2>/dev/null)
  $(mv ./create-eks/tagsubnets-byovpc.tf ./ccreate-eks/tagsubnets-byovpc.not-in-use 2>/dev/null)
}

setByovpcTFs(){
  $(mv ./create-eks/data-sources-byovpc.not-in-use ./create-eks/data-sources-byovpc.tf 2>/dev/null)
  $(mv ./create-eks/worker-nodes-byovpc.not-in-use ./create-eks/worker-nodes-byovpc.tf 2>/dev/null)
  $(mv ./create-eks/eks-cluster-byovpc.not-in-use ./create-eks/eks-cluster-byovpc.tf 2>/dev/null)
  $(mv ./create-eks/tagsubnets-byovpc.not-in-use ./create-eks/tagsubnets-byovpc.tf 2>/dev/null)
}

setCreateAllTFs(){
  $(mv ./create-eks/data-sources.not-in-use ./create-eks/data-sources.tf 2>/dev/null)
  $(mv ./create-eks/worker-nodes.not-in-use ./create-eks/worker-nodes.tf 2>/dev/null)
  $(mv ./create-eks/eks-cluster.not-in-use ./create-eks/eks-cluster.tf 2>/dev/null)
  $(mv ./create-eks/vpc.not-in-use ./create-eks/vpc.tf 2>/dev/null)
}


cleanup
while getopts ':b:dh' OPTION; do
  case "$OPTION" in
    b)
      createModeArg="$OPTARG"
      createmode=true
      resetTFs
      if [[ "${OPTARG,,}" == "byovpc" ]]; then
        echo "Create Mode = BYOVPC"
  setByovpcTFs
      elif [[ "${OPTARG,,}" == "all" ]]; then
        echo "Create Mode = ALL"
  setCreateAllTFs
      elif [[ "${OPTARG,,}" == "byovpc-eks" ]]; then
        echo "Create Mode = BYOVPC and EKS Only"
  setByovpcTFs
  eksonly=true
      elif [[ "${OPTARG,,}" == "eks" ]]; then
        echo "Create Mode = EKS Only"
  setCreateAllTFs
  eksonly=true
      else
  echo "Not a valid option.  Use: all, eks, byopvc, byovpc-eks"
  exit 1
      fi
      ;;
    d)
      echo "Destroy all"
      destroy=true
      ;;
    h)
      echo "Options"
      echo "Create all EKS & ECK assets: $0 -b all"
      echo "Create all EKS & ECK on your vpc/subnets: $0 -b byovpc" 
      echo "Create EKS: $0 -b eks" 
      echo "Create EKS on your vpc/subnes: $0 -b byovpc-eks" 
      echo "Destroy all assets build by 1Click: $0 -d "
      exit 0
      ;;
    *)
      usage
      ;;
  esac
done
shift "$(($OPTIND -1))"

if [ $createmode != true ] && [ $destroy != true ] && [ $eksonly != true ]; then
    usage
fi


if [ $destroy == true ] && [ $createmode == true ] ; then
        echo "create and destroy cant be set together" >&2
        exit 1
fi


if [ $destroy == true ] && [ $eksonly == true ] ; then
        echo 'create and destroy cant be set together' >&2
        exit 1
fi


start=$SECONDS
chmod 700 ./create-eks/1ClickEKSDeploy.sh
chmod 700 ./create-eck/cleanup.sh
chmod 700 ./create-eck/getKibanaInfo.sh
chmod 700 ./create-eck/1ClickECKDeploy.sh
chmod 700 ./create-eck/eck-add-license.sh
chmod 700 ./create-eck/create-operator/1ClickECKOperator.sh



echo "Moving variable files to sub directories"
cp -f ./terraform.tfvars ./create-eks/
cp -f ./variables.tf ./create-eks/
cp -f ./terraform.tfvars ./create-eck/
cp -f ./variables.tf ./create-eck/
cp -f ./terraform.tfvars ./create-eck/create-operator/
cp -f ./variables.tf ./create-eck/create-operator/

if [ $createmode == true ] && [ $eksonly == false ]; then
   (cd ./create-eks ; sh ./1ClickEKSDeploy.sh)
   (cd ./create-eck ; sh ./1ClickECKDeploy.sh)
   duration=$(( SECONDS - start ))
   echo Total deployment time in seconds: $duration
elif [ $createmode == true ] && [ $eksonly == true ]; then
   #(cd ./create-eks ; terraform destroy -auto-approve 2>/dev/null)
   (cd ./create-eks ; sh ./1ClickEKSDeploy.sh)
   duration=$(( SECONDS - start ))
elif [[ $destroy == true ]]; then
   (cd ./create-eck ; sh ./cleanup.sh 2>/dev/null)
   (cd ./create-eks ; terraform destroy -auto-approve 2>/dev/null)
   duration=$(( SECONDS - start ))
   echo Total deployment time in seconds: $duration
else
   echo "Please submit a valid argument"
   echo "Valid arguments:"
   echo "    create"
   echo "    destroy"
fi
