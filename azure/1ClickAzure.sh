#!/bin/bash
export KUBE_CONFIG_PATH=~/.kube/config
$(mkdir ./logs 2>/dev/null)
LOG_LOCATION=./logs
exec > >(tee -i $LOG_LOCATION/1Click.log)
exec 2>&1

echo "Log Location should be: [ $LOG_LOCATION ]"

export KUBE_CONFIG_PATH=~/.kube/config
chmod 700 ./aks/1ClickAKSDeploy.sh
chmod 700 ./aks/addons/1ClickAddons.sh
chmod 700 ./aks/setkubectl.sh
chmod 700 ./eck/1ClickECKDestroy.sh
chmod 700 ./eck/getClusterInfo.sh
chmod 700 ./eck/1ClickECKDeploy.sh
chmod 700 ./aks/setDataSourceRG.sh
chmod 700 ./eck/namegen/1ClickNameGen.sh
chmod 700 ./aks/1ClickAKSDestroy.sh
chmod 700 ./eck/license/1ClickAddLicense.sh
chmod 700 ./eck/license/1ClickAddLicenseDestroy.sh
chmod 700 ./aks/addons/1ClickAddons.sh
chmod 700 ./aks/addons/1ClickAddonsDestroy.sh
chmod 700 ./eck/1ClickECKDestroy.sh
chmod 700 ./eck/getClusterInfo.sh
chmod 700 ./eck/1ClickECKDeploy.sh
chmod 700 ./eck/1ClickECKDestroy.sh
chmod 700 ./aks/addons/custom/1ClickAddons.sh
chmod 700 ./aks/addons/custom/1ClickAddonsDestroy.sh
chmod 700 ./aks/addons/ksm/1ClickAddons.sh
chmod 700 ./aks/addons/ksm/1ClickAddonsDestroy.sh
chmod 700 ./aks/addons/openebs/1ClickAddons.sh
chmod 700 ./aks/addons/openebs/1ClickAddonsDestroy.sh
chmod 700 ./aks/addons/iscsi/1ClickAddons.sh
chmod 700 ./aks/addons/iscsi/1ClickAddonsDestroy.sh
chmod 700 ./aks/setkubectl.sh


usage() {
     echo "Usage: $0 [-b <all | aks >] [-d for destroy] [-de for destroy eck] [-i for clusterinfo] [-r disable openebs] [-h for help]."
     echo "Hit enter to try again with correct arguments"
     exit 0;
}


cleanup() {
  createmode=false
  destroy=false
  aksonly=false
  createModeArg=NA
  openebs="openebs-disabled"
  destroyeck=false
  createOtel=false
  destroyOtel=false
  eckonly=false

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
      elif [[ "$1" == "otel" ]]; then
	      aksonly=true
        createOtel=true
        echo "Create Mode = AKS & Otel"
      elif [[ "$1" == "eck" ]]; then
	      eckonly=true
        echo "Create Mode = ECK Only"
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
    -de|--destroyeck)
      echo "Destroy ECK"
      destroyeck=true
      shift
      ;;
    -do|--destroyotel)
      echo "Destroy ECK"
      destroyOtel=true
      shift
      ;;
    --openebs)
      echo "Enable OpenEBS"
      openebs="openebs-enabled"
      shift
      ;;
    -h|--help)
      echo "Options"
      echo "Create all AKS & ECK assets: $0 -b all"
      echo "Create AKS: $0 -b aks"
      echo "Create ECK: $0 -b eck"
      echo "Create with OpenEBS: $0 --openebs"
      echo "Destroy all assets build by 1Click: $0 -d "
      exit 0
      ;;
    *)
      usage
      break
      ;;
  esac
done

if [ $createmode != true ] && [ $destroy != true ] && [ $aksonly != true ]  && [ $destroyeck != true ] && [ $destroyOtel != true ] && [ $eckonly != true ]; then
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

if [ $createmode == true ] && [ $aksonly == false ] && [ $eckonly == false ]; then
   echo "1ClickAzure.sh: invoking 1ClickAKSDeploy.sh"
   (cd ./aks ; sh ./1ClickAKSDeploy.sh $openebs)
   echo "1ClickAzure.sh: invoking 1ClickECKDeploy.sh"
   (cd ./eck ; sh ./1ClickECKDeploy.sh)
   duration=$(( SECONDS - start ))
   echo 1ClickAzure.sh: Total deployment time in seconds: $duration
elif [ $createmode == true ] && [ $aksonly == true ] && [ $createOtel == true ]; then
   echo "1ClickAzure.sh: invoking 1ClickAKSDeploy.sh"
   (cd ./aks ; bash ./1ClickAKSDeploy.sh $openebs)
   echo "1ClickAzure.sh: invoking Otel Demo"
   (cd ./aks/addons/opentelemetry-demo; bash ./1ClickAddons.sh)
   duration=$(( SECONDS - start ))
   echo 1ClickAzure.sh: Total deployment time in seconds: $duration
elif [ $createmode == true ] && [ $aksonly == true ] && [ $createOtel == false ]; then
   echo "1ClickAzure.sh: invoking 1ClickAKSDeploy.sh"
   (cd ./aks ; bash ./1ClickAKSDeploy.sh $openebs)
   duration=$(( SECONDS - start ))
   echo 1ClickAzure.sh: Total deployment time in seconds: $duration
elif [ $createmode == true ] && [ $eckonly == true ] && [ $aksonly == false ]; then
   echo "1ClickAzure.sh: invoking 1ClickECKDeploy.sh"
   (cd ./eck ; bash ./1ClickECKDeploy.sh $openebs)
   duration=$(( SECONDS - start ))
   echo 1ClickAzure.sh: Total deployment time in seconds: $duration
elif [[ $destroy == true ]]; then
   echo "1ClickAzure.sh: invoking 1ClickECKDestroy.sh"
   (cd ./eck ; sh ./1ClickECKDestroy.sh)
   echo "1ClickAzure.sh: invoking 1ClickAKSDestroy.sh"
   (cd ./aks; bash ./1ClickAKSDestroy.sh)
   duration=$(( SECONDS - start ))
   echo 1ClickAzure.sh: Total deployment time in seconds: $duration
elif [[ $destroyeck == true ]]; then
   echo "1ClickAzure.sh destroy eck"
   echo "1ClickAzure.sh: invoking 1ClickECKDestroy.sh"
   (cd ./eck ; bash ./1ClickECKDestroy.sh)
   echo 1ClickAzure.sh: Total deployment time in seconds: $duration
elif [[ $destroyOtel == true ]]; then
   echo "1ClickAzure.sh destroy Otel"
   (cd ./aks/addons/opentelemetry-demo ; bash ./1ClickAddonsDestroy.sh)
   echo 1ClickAzure.sh: Total deployment time in seconds: $duration
else
   echo "Please submit a valid arguments"
fi
