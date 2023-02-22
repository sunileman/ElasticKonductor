#!/bin/bash

$(mkdir ./logs 2>/dev/null)
LOG_LOCATION=./logs
nowtime=`date +"%m_%d_%Y_%s"`

oneclickv=.44

usage() {
     echo "Usage: $0 [-c [aws | azure | gcp ] [-b <all | k8s>] [-d for destroy] [-r for create without openebs] [-h for help]."
     echo "Hit enter to try again with correct arguments"
     exit 0;
}

cleanup() {
  createmode=false
  k8sonly=false
  destroy=false
  createModeArg=NA
  cloud=NA
  openebs_enabled=""
}


cleanup
# process command line arguments
while [[ "$#" -gt 0 ]]; do
  case "$1" in
    -c|--cloud)
      shift
      if [[ "$1" == "aws" ]]; then
        echo "Cloud: AWS"
      	cloud="aws"
      elif [[ "$1" == "azure" ]]; then
        echo "Cloud: Azure"
      	cloud="azure"
      elif [[ "$1" == "gcp" ]]; then
        echo "Cloud: GCP"
        cloud="gcp"
      else
      	echo "Not a valid cloud provider. Use: aws|azure|gcp"
        exit 1
      fi
      shift
      ;;
    -b|--build)
      shift
      createModeArg="$1"
      createmode=true
      if [[ "$1" == "all" ]]; then
        echo "Build Mode = ALL"
      elif [[ "$1" == "k8s" ]]; then
        echo "Build Mode = K8s Only"
	      k8sonly=true
      else
        echo "Not a valid build option. Use: all or k8s"
        exit 1
      fi
      shift
      ;;
    -r|--removeopenebs)
      echo "Disable OpenEBS"
      openebs_enabled="-r"
      shift
      ;;
    -d|--destroy)
      echo "Destroy all"
      destroy=true
      shift
      ;;
    -h|--help)
      echo "Options"
      echo "Create all K8s & ECK assets: $0 -b all"
      echo "Create K8s: $0 -b k8s"
      echo "Create without OpenEBS: $0 -r"
      echo "Destroy all assets built by 1Click: $0 -d [-c aws|azure|gcp] "
      exit 0
      ;;
    -v|--version)
      echo
      echo "Version $oneclickv"
      exit 0
      ;;
    *)
      usage
      break
      ;;
  esac
done

chmod 700 ./aws/1ClickAWS.sh
chmod 700 ./aws/getClusterInfo.sh
chmod 700 ./gcp/1ClickGCP.sh
chmod 700 ./gcp/getClusterInfo.sh
chmod 700 ./azure/1ClickAzure.sh
chmod 700 ./azure/getClusterInfo.sh

exec > >(tee -i $LOG_LOCATION/1Click_${cloud}_${nowtime}.log)
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

set -e
start=$SECONDS

export KUBE_CONFIG_PATH=~/.kube/config
if [ $cloud == "aws" ]; then
    if [ $createmode == true ] && [ $k8sonly == false ]; then
       echo "1ClickECK.sh: calling 1ClickAWS.sh with all"
       (cd ./aws; bash ./1ClickAWS.sh -b all $openebs_enabled)
       duration=$(( SECONDS - start ))
       echo 1ClickECK.sh: Total deployment time in seconds: $duration
    elif [ $createmode == true ] && [ $k8sonly == true ]; then
       echo "1ClickECK.sh: calling 1ClickAWS.sh eks only"
       (cd ./aws; bash ./1ClickAWS.sh -b eks $openebs_enabled)
       duration=$(( SECONDS - start ))
    elif [[ $destroy == true ]]; then
       echo "1ClickECK.sh: calling 1ClickAWS.sh destroy"
       (cd ./aws; bash ./1ClickAWS.sh -d)
       duration=$(( SECONDS - start ))
       echo 1ClickECK.sh: Total deployment time in seconds: $duration
    else
       echo "Please submit a valid argument"
       echo "Valid arguments:"
       echo "    create"
       echo "    destroy"
    fi
elif [[ $cloud == azure ]]; then
    if [ $createmode == true ] && [ $k8sonly == false ]; then
       echo "1ClickECK.sh: calling 1ClickAzure.sh with all"
       (cd ./azure; bash ./1ClickAzure.sh -b all $openebs_enabled)
       duration=$(( SECONDS - start ))
       echo Total deployment time in seconds: $duration
    elif [ $createmode == true ] && [ $k8sonly == true ]; then
       echo "1ClickECK.sh: calling 1ClickAzure.sh aks only"
       (cd ./azure; bash ./1ClickAzure.sh -b aks $openebs_enabled)
       duration=$(( SECONDS - start ))
    elif [[ $destroy == true ]]; then
       echo "1ClickECK.sh: calling 1ClickAzure.sh destroy"
       (cd ./azure; bash ./1ClickAzure.sh -d )
       duration=$(( SECONDS - start ))
       echo 1ClickECK.sh: Total deployment time in seconds: $duration
    else
       echo "Please submit a valid argument"
       echo "Valid arguments:"
       echo "    create"
       echo "    destroy"
    fi
elif [[ $cloud == gcp ]]; then
    if [ $createmode == true ] && [ $k8sonly == false ]; then
       echo "1ClickECK.sh: calling 1ClickGCP.sh with all"
       (cd ./gcp; bash ./1ClickGCP.sh -b all $openebs_enabled)
       duration=$(( SECONDS - start ))
       echo 1ClickECK.sh: Total deployment time in seconds: $duration
    elif [ $createmode == true ] && [ $k8sonly == true ]; then
       echo "1ClickECK.sh: calling 1ClickGCP.sh gke only"
       (cd ./gcp; bash ./1ClickGCP.sh -b gke $openebs_enabled)
       duration=$(( SECONDS - start ))
    elif [[ $destroy == true ]]; then
       echo "1ClickECK.sh: calling 1ClickGCP.sh destroy"
       (cd ./gcp; bash ./1ClickGCP.sh -d)
       duration=$(( SECONDS - start ))
       echo 1ClickECK.sh: Total deployment time in seconds: $duration
    else
       echo "Please submit a valid argument"
       echo "Valid arguments:"
       echo "    create"
       echo "    destroy"
    fi
else
  echo "Not a valid cloud provider"
fi
