#!/bin/bash
$(mkdir ./logs 2>/dev/null)
LOG_LOCATION=./logs
exec > >(tee -i $LOG_LOCATION/1Click.log)
exec 2>&1

echo "Log Location should be: [ $LOG_LOCATION ]"

usage() {
     echo "Usage: $0 [-b <all | eks >] [-d for destroy] [-h for help]."
     echo "Hit enter to try again with correct arguments" exit 0;
}

cleanup() {
  createmode=false
  eksonly=false
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
      elif [[ "${OPTARG,,}" == "eks" ]]; then
        echo "Create Mode = EKS Only"
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
      echo "Create EKS: $0 -b eks" 
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
