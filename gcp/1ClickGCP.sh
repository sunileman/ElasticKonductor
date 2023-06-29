#!/bin/bash
export KUBE_CONFIG_PATH=~/.kube/config
$(mkdir ./logs 2>/dev/null)
LOG_LOCATION=./logs
exec > >(tee -i $LOG_LOCATION/1Click.log)
exec 2>&1

echo "Log Location should be: [ $LOG_LOCATION ]"

usage() {
     echo "Usage: $0 [-b <all | gke >] [-d for destroy] [-de for destroy eck] [-i for clusterinfo] [-r disable openebs] [-h for help]."
     echo "Hit enter to try again with correct arguments" 
     exit 0;
}

cleanup() {
  createmode=false
  gkeonly=false
  destroy=false
  createModeArg=NA
  openebs="openebs-enabled"
  destroyeck=false
  createOtel=false
  destroyOtel=false
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
      elif [[ "$1" == "gke" ]]; then
	      gkeonly=true
        echo "Create Mode = GKE Only"
      elif [[ "$1" == "otel" ]]; then
	      gkeonly=true
        createOtel=true
        echo "Create Mode = AKS & Otel"
      else
        echo "Not a valid option.  Use: all or gke"
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
    -r|--removeopenebs)    
      echo "Disable OpenEBS"
      openebs="openebs-disabled"
      shift
      ;;
    -h|--help)
      echo "Options"
      echo "Create all GKE & ECK assets: $0 -b all"
      echo "Create GKE: $0 -b gke" 
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




if [ $createmode != true ] && [ $destroy != true ] && [ $gkeonly != true ] && [ $destroyeck != true ] && [ $destroyOtel != true ]; then
    usage
fi


if [ $destroy == true ] && [ $createmode == true ] ; then
        echo "create and destroy cant be set together" >&2
        exit 1
fi


if [ $destroy == true ] && [ $gkeonly == true ] ; then
        echo 'create and destroy cant be set together' >&2
        exit 1
fi

set -e
start=$SECONDS
chmod 700 ./gke/1ClickGKEDeploy.sh
chmod 700 ./gke/1ClickGKEDestroy.sh
chmod 700 ./eck/license/1ClickAddLicense.sh
chmod 700 ./eck/license/1ClickAddLicenseDestroy.sh
chmod 700 ./gke/addons/1ClickAddons.sh
chmod 700 ./gke/addons/1ClickAddonsDestroy.sh
chmod 700 ./gke/gke-workers/1ClickGKEWorkersDeploy.sh
chmod 700 ./gke/gke-workers/1ClickGKEWorkersDestroy.sh
chmod 700 ./gke/gke-workers/cold/1ClickGKEColdDeploy.sh
chmod 700 ./gke/gke-workers/cold/1ClickGKEColdDestroy.sh
chmod 700 ./gke/gke-workers/frozen/1ClickGKEFrozenDeploy.sh
chmod 700 ./gke/gke-workers/frozen/1ClickGKEFrozenDestroy.sh
chmod 700 ./gke/gke-workers/hot/1ClickGKEHotDeploy.sh
chmod 700 ./gke/gke-workers/hot/1ClickGKEHotDestroy.sh
chmod 700 ./gke/gke-workers/kibana/1ClickGKEKibanaDeploy.sh
chmod 700 ./gke/gke-workers/kibana/1ClickGKEKibanaDestroy.sh
chmod 700 ./gke/gke-workers/master/1ClickGKEMasterDeploy.sh
chmod 700 ./gke/gke-workers/master/1ClickGKEMasterDestroy.sh
chmod 700 ./gke/gke-workers/ml/1ClickGKEMLDeploy.sh
chmod 700 ./gke/gke-workers/ml/1ClickGKEMLDestroy.sh
chmod 700 ./gke/gke-workers/util/1ClickGKEUtilDeploy.sh
chmod 700 ./gke/gke-workers/util/1ClickGKEUtilDestroy.sh
chmod 700 ./gke/gke-workers/warm/1ClickGKEWarmDeploy.sh
chmod 700 ./gke/gke-workers/warm/1ClickGKEWarmDestroy.sh
chmod 700 ./eck/1ClickECKDestroy.sh
chmod 700 ./eck/getClusterInfo.sh
chmod 700 ./eck/1ClickECKDeploy.sh
chmod 700 ./eck/1ClickECKDestroy.sh
chmod 700 ./eck/es-operator/1ClickECKOperator.sh
chmod 700 ./eck/es-operator/1ClickECKOperatorDestroy.sh
chmod 700 ./gke/addons/custom/1ClickAddons.sh
chmod 700 ./gke/addons/custom/1ClickAddonsDestroy.sh
chmod 700 ./gke/addons/ksm/1ClickAddons.sh
chmod 700 ./gke/addons/ksm/1ClickAddonsDestroy.sh
chmod 700 ./gke/addons/openebs/1ClickAddons.sh
chmod 700 ./gke/addons/openebs/1ClickAddonsDestroy.sh
chmod 700 ./gke/addons/iscsi/1ClickAddons.sh
chmod 700 ./gke/addons/iscsi/1ClickAddonsDestroy.sh
chmod 700 ./gke/setkubectl.sh



if [ $createmode == true ] && [ $gkeonly == false ]; then
   echo "1ClickGCP.sh: invoking 1ClickGKEDeploy.sh"
   (cd ./gke ; sh ./1ClickGKEDeploy.sh $openebs)
   echo "1ClickGCP.sh: invoking 1ClickECKDeploy.sh"
   (cd ./eck ; sh ./1ClickECKDeploy.sh)
   duration=$(( SECONDS - start ))
   echo 1ClickGCP.sh: Total deployment time in seconds: $duration
elif [ $createmode == true ] && [ $gkeonly == true ]  && [ $createOtel == true ]; then
   echo "1ClickGCP.sh: invoking 1ClickGKEDeploy.sh"
   (cd ./gke ; sh ./1ClickGKEDeploy.sh $openebs)
   echo "1ClickGCP.sh: invoking Otel Demo"
   (cd ./gke/addons/opentelemetry-demo; bash ./1ClickAddons.sh)
   duration=$(( SECONDS - start ))
   echo 1ClickGCP.sh: Total deployment time in seconds: $duration
elif [ $createmode == true ] && [ $gkeonly == true ] && [ $createOtel == false ]; then
   echo "1ClickGCP.sh: invoking 1ClickGKEDeploy.sh"
   (cd ./gke ; bash ./1ClickGKEDeploy.sh $openebs)
   duration=$(( SECONDS - start ))
   echo 1ClickAzure.sh: Total deployment time in seconds: $duration
elif [[ $destroy == true ]]; then
   echo "1ClickGCP.sh destroy all"
   echo "1ClickGCP.sh: invoking 1ClickECKDestroy.sh"
   (cd ./eck ; bash ./1ClickECKDestroy.sh)
   echo "1ClickGCP.sh: invoking 1ClickGKEDestroy.sh"
   (cd ./gke; bash ./1ClickGKEDestroy.sh)
   duration=$(( SECONDS - start ))
   echo 1ClickGCP.sh: Total deployment time in seconds: $duration
elif [[ $destroyeck == true ]]; then
   echo "1ClickGCP.sh destroy eck"
   echo "1ClickGCP.sh: invoking 1ClickECKDestroy.sh"
   (cd ./eck ; bash ./1ClickECKDestroy.sh)
   echo 1ClickGCP.sh: Total deployment time in seconds: $duration
elif [[ $destroyOtel == true ]]; then
   echo "1ClickGCP.sh destroy Otel"
   (cd ./gke/addons/opentelemetry-demo ; bash ./1ClickAddonsDestroy.sh)
   echo 1ClickGCP.sh: Total deployment time in seconds: $duration
else
   echo "Please submit a valid arguments"
fi
