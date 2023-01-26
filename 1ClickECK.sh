#!/bin/bash
$(mkdir ./logs 2>/dev/null)
LOG_LOCATION=./logs
nowtime=`date +"%m_%d_%Y_%s"`

oneclickv=.16

usage() {
     echo "Usage: $0 [-c [aws | azure | gcp ] [-b <all | k8s>] [-d for destroy] [-h for help]."
     echo "Hit enter to try again with correct arguments"
     exit 0;
}

cleanup() {
  createmode=false
  k8sonly=false
  destroy=false
  createModeArg=NA
  cloud=NA
}

cleanup
while getopts ':b:c:dhv' OPTION; do
  case "$OPTION" in
    b)
      createModeArg="$OPTARG"
      createmode=true
      if [[ "${OPTARG,,}" == "all" ]]; then
        echo "Build Mode = ALL"
      elif [[ "${OPTARG,,}" == "k8s" ]]; then
        echo "Build Mode = K8s Only"
	k8sonly=true
      else
        echo "Not a valid option.  Use: all or k8s"
        exit 1
      fi
      ;;
    c)
      if [[ "${OPTARG,,}" == "aws" ]]; then
        echo "Cloud: AWS"
      	cloud="aws"
      elif [[ "${OPTARG,,}" == "azure" ]]; then
        echo "Cloud: Azure"
      	cloud="azure"
      elif [[ "${OPTARG,,}" == "gcp" ]]; then
        echo "Cloud: GCP"
        cloud="gcp"
      else
      	echo "Not a valid option.  Use: aws|azure|gcp"
        exit 1
      fi
      ;;
    d)
      echo "Destroy all"
      destroy=true
      ;;
    h)
      echo "Options"
      echo "Create all K8s & ECK assets: $0 -b all"
      echo "Create K8s: $0 -b k8s"
      echo "Destroy all assets built by 1Click: $0 -d [-c aws|azure|gcp] "
      exit 0
      ;;
    v)
      echo
      echo "Version $oneclickv"
      exit 0
      ;;
    *)
      usage
      ;;
  esac
done
shift "$(($OPTIND -1))"


exec > >(tee -i $LOG_LOCATION/1Click_$cloud_$nowtime.log)
exec 2>&1
echo "Log Location: [ $LOG_LOCATION ]"

if [ $createmode != true ] && [ $destroy != true ] && [ $k8sonly != true ]; then
    usage
fi


if [ $destroy == true ] && [ $createmode == true ] ; then
        echo "create and destroy cant be set together" >&2
        exit 1
fi

if [ $destroy == true ] && [ $cloud == "NA" ] ; then
        echo "Destroy requires -c" >&2
        exit 1
fi

if [ $createmode == true ] && [ $cloud == "NA" ] ; then
        echo "Build requires -c" >&2
        exit 1
fi

if [ $destroy == true ] && [ $k8sonly == true ] ; then
        echo 'create and destroy cant be set together' >&2
        exit 1
fi

echo
echo
echo
echo version $oneclickv
echo author: sunile manjee
echo last update: 12/22/2022
echo
echo Welcome to...
echo "                                                    ";
echo "  __   _____  _  _        _     ______  _____  _  __";
echo " /_ | / ____|| |(_)      | |   |  ____|/ ____|| |/ /";
echo "  | || |     | | _   ___ | | __| |__  | |     | ' / ";
echo "  | || |     | || | / __|| |/ /|  __| | |     |  <  ";
echo "  | || |____ | || || (__ |   < | |____| |____ | . \ ";
echo "  |_| \_____||_||_| \___||_|\_\|______|\_____||_|\_\ ";
echo "                                                    ";
echo "                                                    ";
echo "                                                                                    ";
echo "                                                                                    ";


#https://patorjk.com/software/taag/#p=display&h=1&v=1&c=echo&f=Chiseled&t=1ClickECK#


start=$SECONDS

export KUBE_CONFIG_PATH=~/.kube/config
if [ $cloud == "aws" ]; then
    if [ $createmode == true ] && [ $k8sonly == false ]; then
       (cd ./aws; bash ./1ClickAWS.sh -b all)
       duration=$(( SECONDS - start ))
       echo Total deployment time in seconds: $duration
    elif [ $createmode == true ] && [ $k8sonly == true ]; then
       (cd ./aws; bash ./1ClickAWS.sh -b eks)
       duration=$(( SECONDS - start ))
    elif [[ $destroy == true ]]; then
       (cd ./aws; bash ./1ClickAWS.sh -d)
       duration=$(( SECONDS - start ))
       echo Total deployment time in seconds: $duration
    else
       echo "Please submit a valid argument"
       echo "Valid arguments:"
       echo "    create"
       echo "    destroy"
    fi
elif [[ $cloud == azure ]]; then
    if [ $createmode == true ] && [ $k8sonly == false ]; then
       (cd ./azure; bash ./1ClickAzure.sh -b all)
       duration=$(( SECONDS - start ))
       echo Total deployment time in seconds: $duration
    elif [ $createmode == true ] && [ $k8sonly == true ]; then
       (cd ./azure; bash ./1ClickAzure.sh -b aks)
       duration=$(( SECONDS - start ))
    elif [[ $destroy == true ]]; then
       (cd ./azure; bash ./1ClickAzure.sh -d )
       duration=$(( SECONDS - start ))
       echo Total deployment time in seconds: $duration
    else
       echo "Please submit a valid argument"
       echo "Valid arguments:"
       echo "    create"
       echo "    destroy"
    fi
elif [[ $cloud == gcp ]]; then
    if [ $createmode == true ] && [ $k8sonly == false ]; then
       (cd ./gcp; bash ./1ClickGCP.sh -b all)
       duration=$(( SECONDS - start ))
       echo Total deployment time in seconds: $duration
    elif [ $createmode == true ] && [ $k8sonly == true ]; then
       (cd ./gcp; bash ./1ClickGCP.sh -b gke)
       duration=$(( SECONDS - start ))
    elif [[ $destroy == true ]]; then
       (cd ./gcp; bash ./1ClickGCP.sh -d )
       duration=$(( SECONDS - start ))
       echo Total deployment time in seconds: $duration
    else
       echo "Please submit a valid argument"
       echo "Valid arguments:"
       echo "    create"
       echo "    destroy"
    fi
else
  echo "Not a valid cloud provider"
fi
