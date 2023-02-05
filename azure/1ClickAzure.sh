#!/bin/bash
export KUBE_CONFIG_PATH=~/.kube/config
$(mkdir ./logs 2>/dev/null)
LOG_LOCATION=./logs
exec > >(tee -i $LOG_LOCATION/1Click.log)
exec 2>&1

echo "Log Location should be: [ $LOG_LOCATION ]"

export KUBE_CONFIG_PATH=~/.kube/config
chmod 700 ./create-aks/1ClickAKSDeploy.sh
chmod 700 ./create-aks/addons/1ClickAddons.sh
chmod 700 ./create-aks/setkubectl.sh
chmod 700 ./create-eck/1ClickECKDestroy.sh
chmod 700 ./create-eck/getClusterInfo.sh
chmod 700 ./create-eck/1ClickECKDeploy.sh
chmod 700 ./create-eck/eck-add-license.sh
chmod 700 ./create-aks/setDataSourceRG.sh
chmod 700 ./create-eck/namegen/1ClickNameGen.sh
chmod 700 ./create-eck/create-operator/1ClickECKOperator.sh


usage() {
     echo "Usage: $0 [-b <all | aks >] [-d for destroy] [-r disable openebs] [-h for help]."
     echo "Hit enter to try again with correct arguments"
     exit 0;
}


cleanup() {
  createmode=false
  destroy=false
  aksonly=false
  createModeArg=NA
  openebs="openebs-enabled"
}


cleanup

# process command line arguments
while [[ "$#" -gt 0 ]]; do
  case "$1" in
    -b|--build)
      shift
      createModeArg="$1"
      createmode=true
      if [[ "$1" == "all" ]]; then
        echo "Build Mode = ALL"
      elif [[ "$1" == "aks" ]]; then
	aksonly=true
        echo "Create Mode = AKS Only"
      else
        echo "Not a valid option.  Use: all or aks"
        exit 1
      fi
      shift
      ;;
    -d|--destroy)
      echo "Destroy all"
      destroy=true
      shift
      ;;
    -r|--removeopenebs)
      echo "Disable OpenEBS"
      openebs="openebs-disabled"
      shift
      ;;
    -h|--help)
      echo "Options"
      echo "Create all AKS & ECK assets: $0 -b all"
      echo "Create AKS: $0 -b aks"
      echo "Create without OpenEBS: $0 -r"
      echo "Destroy all assets build by 1Click: $0 -d "
      exit 0
      ;;
    *)
      usage
      break
      ;;
  esac
done

if [ $createmode != true ] && [ $destroy != true ] && [ $aksonly != true ]; then
    usage
fi


if [ $destroy == true ] && [ $createmode == true ] ; then
        echo "create and destroy cant be set together" >&2
        exit 1
fi


if [ $destroy == true ] && [ $aksonly == true ] ; then
        echo 'create and destroy cant be set together' >&2
        exit 1
fi


start=$SECONDS

set -e

if [ $createmode == true ] && [ $aksonly == false ]; then
   echo "1ClickAzure.sh: invoking 1ClickAKSDeploy.sh"
   (cd ./create-aks ; sh ./1ClickAKSDeploy.sh $openebs)
   echo "1ClickAzure.sh: invoking 1ClickECKDeploy.sh"
   (cd ./create-eck ; sh ./1ClickECKDeploy.sh)
   duration=$(( SECONDS - start ))
   echo 1ClickAzure.sh: Total deployment time in seconds: $duration
elif [ $createmode == true ] && [ $aksonly == true ]; then
   echo "1ClickAzure.sh: invoking 1ClickAKSDeploy.sh"
   (cd ./create-aks ; sh ./1ClickAKSDeploy.sh $openebs)
   duration=$(( SECONDS - start ))
elif [[ $destroy == true ]]; then
   echo "1ClickAzure.sh: invoking 1ClickECKDestroy.sh"
   (cd ./create-eck ; sh ./1ClickECKDestroy.sh)
   echo "1ClickAzure.sh: invoking 1ClickAKSDestroy.sh"
   (cd ./create-aks; bash ./1ClickAKSDestroy.sh)
   duration=$(( SECONDS - start ))
   echo 1ClickAzure.sh: Total deployment time in seconds: $duration
else
   echo "Please submit a valid arguments"
fi
