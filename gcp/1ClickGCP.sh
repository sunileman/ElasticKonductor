#!/bin/bash
export KUBE_CONFIG_PATH=~/.kube/config
$(mkdir ./logs 2>/dev/null)
LOG_LOCATION=./logs
exec > >(tee -i $LOG_LOCATION/1Click.log)
exec 2>&1

echo "Log Location should be: [ $LOG_LOCATION ]"

usage() {
     echo "Usage: $0 [-b <all | gke >] [-d for destroy] [-r disable openebs] [-h for help]."
     echo "Hit enter to try again with correct arguments" 
     exit 0;
}

cleanup() {
  createmode=false
  gkeonly=false
  destroy=false
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
      elif [[ "$1" == "gke" ]]; then
	gkeonly=true
        echo "Create Mode = GKE Only"
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




if [ $createmode != true ] && [ $destroy != true ] && [ $gkeonly != true ]; then
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
chmod 700 ./create-gke/1ClickGKEDeploy.sh
chmod 700 ./create-gke/addons/1ClickAddons.sh
chmod 700 ./create-eck/1ClickECKDestroy.sh
chmod 700 ./create-eck/getClusterInfo.sh
chmod 700 ./create-eck/1ClickECKDeploy.sh
chmod 700 ./create-eck/create-operator/1ClickECKOperator.sh



if [ $createmode == true ] && [ $gkeonly == false ]; then
   echo "1ClickGCP.sh: invoking 1ClickGKEDeploy.sh"
   (cd ./create-gke ; sh ./1ClickGKEDeploy.sh $openebs)
   echo "1ClickGCP.sh: invoking 1ClickECKDeploy.sh"
   (cd ./create-eck ; sh ./1ClickECKDeploy.sh)
   duration=$(( SECONDS - start ))
   echo 1ClickGCP.sh: Total deployment time in seconds: $duration
elif [ $createmode == true ] && [ $gkeonly == true ]; then
   echo "1ClickGCP.sh: invoking 1ClickGKEDeploy.sh"
   (cd ./create-gke ; sh ./1ClickGKEDeploy.sh $openebs)
   duration=$(( SECONDS - start ))
elif [[ $destroy == true ]]; then
   echo "1ClickGCP.sh: invoking 1ClickECKDestroy.sh"
   (cd ./create-eck ; bash ./1ClickECKDestroy.sh)
   echo "1ClickGCP.sh: invoking 1ClickGKEDestroy.sh"
   (cd ./create-gke; bash ./1ClickGKEDestroy.sh)
   duration=$(( SECONDS - start ))
   echo 1ClickGCP.sh: Total deployment time in seconds: $duration
else
   echo "Please submit a valid arguments"
fi
