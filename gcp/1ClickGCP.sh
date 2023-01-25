#!/bin/bash
export KUBE_CONFIG_PATH=~/.kube/config
$(mkdir ./logs 2>/dev/null)
LOG_LOCATION=./logs
exec > >(tee -i $LOG_LOCATION/1Click.log)
exec 2>&1

echo "Log Location should be: [ $LOG_LOCATION ]"

usage() {
     echo "Usage: $0 [-b <all | gke >] [-d for destroy] [-h for help]."
     echo "Hit enter to try again with correct arguments" exit 0;
}

cleanup() {
  createmode=false
  gkeonly=false
  destroy=false
  createModeArg=NA
}



cleanup
while getopts ':b:dh' OPTION; do
  case "$OPTION" in
    b)
      createModeArg="$OPTARG"
      createmode=true
      if [[ "${OPTARG,,}" == "all" ]]; then
        echo "Build Mode = ALL"
      elif [[ "${OPTARG,,}" == "gke" ]]; then
        echo "Create Mode = GKE Only"
      else
        echo "Not a valid option.  Use: all or gke"
        exit 1
      fi
      ;;
    d)
      echo "Destroy all"
      destroy=true
      ;;
    h)
      echo "Options"
      echo "Create all GKE & ECK assets: $0 -b all"
      echo "Create EKS: $0 -b gke" 
      echo "Destroy all assets build by 1Click: $0 -d "
      exit 0
      ;;
    *)
      usage
      ;;
  esac
done
shift "$(($OPTIND -1))"

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


start=$SECONDS
chmod 700 ./create-gke/1ClickGKEDeploy.sh
chmod 700 ./create-gke/addons/1ClickAddons.sh
chmod 700 ./create-eck/cleanup.sh
chmod 700 ./create-eck/getClusterInfo.sh
chmod 700 ./create-eck/1ClickECKDeploy.sh
chmod 700 ./create-eck/eck-add-license.sh
chmod 700 ./create-eck/create-operator/1ClickECKOperator.sh



if [ $createmode == true ] && [ $gkeonly == false ]; then
   (cd ./create-gke ; sh ./1ClickGKEDeploy.sh)
   (cd ./create-eck ; sh ./1ClickECKDeploy.sh)
   duration=$(( SECONDS - start ))
   echo Total deployment time in seconds: $duration
elif [ $createmode == true ] && [ $gkeonly == true ]; then
   #(cd ./create-gke ; terraform destroy -auto-approve 2>/dev/null)
   (cd ./create-gke ; sh ./1ClickGKEDeploy.sh)
   duration=$(( SECONDS - start ))
elif [[ $destroy == true ]]; then
   (cd ./create-eck ; sh ./cleanup.sh 2>/dev/null)
   (cd ./create-gke/addons ; terraform destroy -auto-approve 2>/dev/null)
   (cd ./create-gke ; terraform destroy -auto-approve 2>/dev/null)
   duration=$(( SECONDS - start ))
   echo Total deployment time in seconds: $duration
else
   echo "Please submit a valid argument"
   echo "Valid arguments:"
   echo "    create"
   echo "    destroy"
fi
