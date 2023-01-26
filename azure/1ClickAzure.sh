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
chmod 700 ./create-eck/cleanup.sh
chmod 700 ./create-eck/getClusterInfo.sh
chmod 700 ./create-eck/1ClickECKDeploy.sh
chmod 700 ./create-eck/eck-add-license.sh
chmod 700 ./create-aks/setDataSourceRG.sh
chmod 700 ./create-eck/namegen/1ClickNameGen.sh
chmod 700 ./create-eck/create-operator/1ClickECKOperator.sh


usage() {
     echo "Usage: $0 [-b <all | aks> ] [-d for destroy] [-h for help]."
     echo "Hit enter to try again with correct arguments"
     exit 0;
}

cleanup() {
  createmode=false
  destroy=false
  aksonly=false
  createModeArg=NA
}


cleanup
while getopts ':b:dh' OPTION; do
  case "$OPTION" in
    b)
      createModeArg="$OPTARG"
      createmode=true
      if [[ "${OPTARG,,}" == "all" ]]; then
        echo "Create Mode = ALL"
      elif [[ "${OPTARG,,}" == "aks" ]]; then
	aksonly=true
        echo "Create Mode = AKS Only"
      else
	echo "Not a valid option.  Use: all or aks"
	exit 1
      fi
      ;;
    d)
      echo "Destroy all"
      destroy=true
      ;;
    h)

      echo "Create all AKS & ECK assets: $0 -b all"
      echo "Create AKS: $0 -b aks" 
      echo "Destroy all assets build by 1Click: $0 -d "
      exit 0
      ;;
    *)
      usage
      ;;
  esac
done
shift "$(($OPTIND -1))"

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


if [ $createmode == true ] && [ $aksonly == false ]; then
   (cd ./create-aks ; sh ./1ClickAKSDeploy.sh)
   (cd ./create-eck ; sh ./1ClickECKDeploy.sh)
   duration=$(( SECONDS - start ))
   echo Total deployment time in seconds: $duration
elif [ $createmode == true ] && [ $aksonly == true ]; then
   #(cd ./create-aks ; terraform destroy -auto-approve 2>/dev/null)
   (cd ./create-aks ; sh ./1ClickAKSDeploy.sh)
   duration=$(( SECONDS - start ))
elif [[ $destroy == true ]]; then
   (cd ./create-eck ; sh ./cleanup.sh 2>/dev/null)
   (cd ./create-aks/addons ; terraform destroy -auto-approve 2>/dev/null)
   (cd ./create-aks ; terraform destroy -auto-approve 2>/dev/null)
   duration=$(( SECONDS - start ))
   echo Total deployment time in seconds: $duration
else
   echo "Please submit a valid arguments"
fi
