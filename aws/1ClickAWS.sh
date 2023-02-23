#!/bin/bash
export KUBE_CONFIG_PATH=~/.kube/config
$(mkdir ./logs 2>/dev/null)
LOG_LOCATION=./logs
exec > >(tee -i $LOG_LOCATION/1Click.log)
exec 2>&1

echo "Log Location should be: [ $LOG_LOCATION ]"

usage() {
     echo "Usage: $0 [-b <all | eks >] [-d for destroy] [-r disable openebs] [-h for help]."
     echo "Hit enter to try again with correct arguments"
     exit 0;
}


cleanup() {
  createmode=false
  eksonly=false
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
      elif [[ "$1" == "eks" ]]; then
	      eksonly=true
        echo "Create Mode = EKS Only"
      else
        echo "Not a valid option.  Use: all or eks"
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
      echo "Create all EKS & ECK assets: $0 -b all"
      echo "Create EKS: $0 -b eks"
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

echo "1ClickAWS.sh openEBS option set to $openebs"

start=$SECONDS
chmod 700 ./eks/1ClickEKSDeploy.sh
chmod 700 ./eks/1ClickEKSDestroy.sh
chmod 700 ./eks/1ClickEKSDestroy.sh
chmod 700 ./eks/addons/1ClickAddons.sh
chmod 700 ./eck/1ClickECKDestroy.sh
chmod 700 ./eck/getClusterInfo.sh
chmod 700 ./eck/1ClickECKDeploy.sh
chmod 700 ./eck/create-operator/1ClickECKOperator.sh
chmod 700 ./eck/create-operator/1ClickECKOperatorDestroy.sh
chmod 700 ./eck/license/1ClickAddLicense.sh
chmod 700 ./eck/license/1ClickAddLicenseDestroy.sh
chmod 700 ./getClusterInfo.sh
chmod 700 ./eck/getClusterInfo.sh
chmod 700 ./eks/setkubectl.sh
chmod 700 ./eks/addons/1ClickAddons.sh
chmod 700 ./eks/addons/1ClickAddonsDestroy.sh
chmod 700 ./eks/addons/autoscaler/1ClickAddons.sh
chmod 700 ./eks/addons/autoscaler/1ClickAddonsDestroy.sh
chmod 700 ./eks/addons/custom/1ClickAddons.sh
chmod 700 ./eks/addons/custom/1ClickAddonsDestroy.sh
chmod 700 ./eks/addons/ksm/1ClickAddons.sh
chmod 700 ./eks/addons/ksm/1ClickAddonsDestroy.sh
chmod 700 ./eks/addons/openebs/1ClickAddons.sh
chmod 700 ./eks/addons/openebs/1ClickAddonsDestroy.sh


set -e

if [ $createmode == true ] && [ $eksonly == false ]; then
   echo "1ClickAWS.sh: invoking 1ClickEKSDeploy.sh"   
   (cd ./eks ; sh ./1ClickEKSDeploy.sh $openebs)
   echo "1ClickAWS.sh: invoking 1ClickECKDeploy.sh"   
   (cd ./eck ; sh ./1ClickECKDeploy.sh)
   duration=$(( SECONDS - start ))
   echo 1ClickAWS.sh: Total deployment time in seconds: $duration
elif [ $createmode == true ] && [ $eksonly == true ]; then
   echo "1ClickAWS.sh: invoking 1ClickEKSDeploy.sh"   
   (cd ./eks ; sh ./1ClickEKSDeploy.sh $openebs)
   duration=$(( SECONDS - start ))
elif [[ $destroy == true ]]; then
   echo "1ClickAWS.sh: invoking 1ClickECKDestroy.sh"   
   (cd ./eck; bash ./1ClickECKDestroy.sh)
   echo "1ClickAWS.sh: invoking 1ClickEKSDestroy.sh"   
   (cd ./eks; bash ./1ClickEKSDestroy.sh)
   duration=$(( SECONDS - start ))
   echo 1ClickAWS.sh: Total deployment time in seconds: $duration
else
   echo "Please submit a valid arguments"
fi
