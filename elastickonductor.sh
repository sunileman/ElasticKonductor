#!/bin/bash

$(mkdir ./logs 2>/dev/null)
LOG_LOCATION=./logs
nowtime=`date +"%m_%d_%Y_%s"`

oneclickv=1.4

usage() {
     echo "Usage: $0 "
     echo "[-c [aws | azure | gcp | ess]"
     echo "[-b <all | k8s | otel>] "
     echo "[-d for destroy]"
     echo "[-de for destroy eck]"
     echo "[-do for destroy otel]"
     echo "[-r for create without openebs]"
     echo "[-inf cluster info]"
     echo "[-i infra info]"
     echo "[-ic install 1ClickECK client]"
     echo "[-h for help]"
     exit 0;
}

cleanup() {
  createmode=false
  k8sonly=false
  destroy=false
  createModeArg=NA
  cloud=NA
  openebs_enabled=""
  getClusterInfo=false
  getInfraInfo=false
  destroyeck=false
  createOtel=false
  destroyOtel=false
  installclient=false
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
      elif [[ "$1" == "ess" ]]; then
        echo "Cloud: ESS"
        cloud="ess"
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
        createAll=true
      elif [[ "$1" == "k8s" ]]; then
        echo "Build Mode = K8s Only"
	      k8sonly=true
      elif [[ "$1" == "otel" ]]; then
        echo "Build Mode = K8s & Otel"
	      k8sonly=true
        createOtel=true
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
    -i|--getClusterInfo)
      echo "Get Cluster Info"
      getClusterInfo=true
      shift
      ;;
    -inf|--getInfraInfo)
      echo "Get Infra Info"
      getInfraInfo=true
      shift
      ;;
    -ic|--installclient)
      echo "Install Client"
      installclient=true
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
      echo "Destroy Otel"
      destroyOtel=true
      shift
      ;;
    -h|--help)
      usage
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

set -e

if [ $installclient == true ] ; then
  echo "Installing 1ClickECK Client"
  (cd scripts; bash ./1ClickECK-client-install.sh)
  exit 0
fi

set +e 

if [ $createmode != true ] && [ $destroy != true ] && [ $k8sonly != true ] && [ $getClusterInfo != true ] && [ $getInfraInfo != true ] && [ $destroyeck != true ]  && [ $destroyOtel != true ]; then
    usage
fi


if [ $destroy == true ] && [ $createmode == true ] ; then
        echo "create and destroy cant be set together" >&2
        exit 1
fi

if [ $destroyeck == true ] && [ $createmode == true ] ; then
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
echo "        _              _    _                _                      _               _               ";
echo "       | |            | |  (_)              | |                    | |             | |              ";
echo "   ___ | |  __ _  ___ | |_  _   ___  ______ | | __ ___   _ __    __| | _   _   ___ | |_  ___   _ __ ";
echo "  / _ \| | / _\` |/ __|| __|| | / __||______|| |/ // _ \ | '_ \  / _\` || | | | / __|| __|/ _ \ | '__|";
echo " |  __/| || (_| |\__ \| |_ | || (__         |   <| (_) || | | || (_| || |_| || (__ | |_| (_) || |   ";
echo "  \___||_| \__,_||___/ \__||_| \___|        |_|\_\\___/ |_| |_| \__,_| \__,_| \___| \__|\___/ |_|   ";
echo "                                                                                                    ";
echo "                                                                                                    ";


#https://patorjk.com/software/taag/#p=display&h=1&v=1&c=echo&f=Chiseled&t=1ClickECK#

set -e
start=$SECONDS

  echo "createmode $createmode"
  echo "k8sonly $k8sonly"
  echo "destroy $destroy"
  echo "createModeArg $createModeArg"
  echo "cloud $cloud"
  echo "openebs_enabled $openebs_enabled"
  echo "getClusterInfo $getClusterInfo"
  echo "destroyeck $destroyeck"
  echo "createOtel $createOtel"
  echo "destroyOtel $destroyOtel"


export KUBE_CONFIG_PATH=~/.kube/config
if [ $cloud == "aws" ]; then
    (cd aws; python prechecks.py)
    if [ $getClusterInfo == true ]; then
       echo "Get cluster Info"
       (cd ./aws; bash ./getClusterInfo.sh)
       duration=$(( SECONDS - start ))
    elif [ $createmode == true ] && [ $k8sonly == false ]; then
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
    elif [[ $destroyeck == true ]]; then
       echo "1ClickECK.sh: calling 1ClickAWS.sh destroy ECK"
       (cd ./aws; bash ./1ClickAWS.sh -de)
       duration=$(( SECONDS - start ))
       echo 1ClickECK.sh: Total deployment time in seconds: $duration
    else
       echo "Please submit a valid argument"
       echo "Valid arguments:"
       echo "    create"
       echo "    destroy"
    fi
elif [[ $cloud == azure ]]; then
    (cd azure; python prechecks.py)
    if [ $getClusterInfo == true ]; then
       echo "Get cluster Info"
       (cd ./azure; bash ./getClusterInfo.sh)
       duration=$(( SECONDS - start ))
       echo "1ClickECK.sh: Total deployment time in seconds:" $duration
    elif [ $getInfraInfo == true ]; then
       echo "Get Infra Info"
       (cd ./azure/aks; bash ./getClusterInfo.sh)
       duration=$(( SECONDS - start ))
       echo "1ClickECK.sh: Total deployment time in seconds:" $duration
    elif [ $createmode == true ] && [ $k8sonly == false ]; then
       echo "1ClickECK.sh: calling 1ClickAzure.sh with all"
       (cd ./azure; bash ./1ClickAzure.sh -b all $openebs_enabled)
       duration=$(( SECONDS - start ))
       echo 1ClickECK.sh: Total deployment time in seconds: $duration
    elif [ $createmode == true ] && [ $k8sonly == true ] && [ $createOtel == true ]; then
       echo "1ClickECK.sh: calling 1ClickAzure.sh with otel"
       (cd ./azure; bash ./1ClickAzure.sh -b otel $openebs_enabled)
       duration=$(( SECONDS - start ))
       echo "1ClickECK.sh: Total deployment time in seconds:" $duration
    elif [ $createmode == true ] && [ $k8sonly == true ] && [ $createOtel == false ]; then
       echo "1ClickECK.sh: calling 1ClickAzure.sh aks only"
       (cd ./azure; bash ./1ClickAzure.sh -b aks $openebs_enabled)
       duration=$(( SECONDS - start ))
       echo "1ClickECK.sh: Total deployment time in seconds:" $duration
    elif [[ $destroy == true ]]; then
       echo "1ClickECK.sh: calling 1ClickAzure.sh destroy"
       (cd ./azure; bash ./1ClickAzure.sh -d )
       duration=$(( SECONDS - start ))
       echo "1ClickECK.sh: Total deployment time in seconds:" $duration
    elif [[ $destroyeck == true ]]; then
       echo "1ClickECK.sh: calling 1ClickAzure.sh destroy ECK"
       (cd ./azure; bash ./1ClickAzure.sh -de)
       duration=$(( SECONDS - start ))
       echo "1ClickECK.sh: Total deployment time in seconds:" $duration
    elif [[ $destroyOtel == true ]]; then
       echo "1ClickECK.sh: Destroying Otel"
       (cd ./azure; bash ./1ClickAzure.sh -do)
       duration=$(( SECONDS - start ))
       echo "1ClickECK.sh: Total deployment time in seconds:" $duration
    else
       echo "Please submit a valid argument"
       echo "Valid arguments:"
       echo "    create"
       echo "    destroy"
    fi
elif [[ $cloud == gcp ]]; then
    (cd gcp; python prechecks.py)
    if [ $getClusterInfo == true ]; then
       echo "Get cluster Info"
       (cd ./gcp; bash ./getClusterInfo.sh)
       duration=$(( SECONDS - start ))
    elif [ $createmode == true ] && [ $k8sonly == false ]; then
       echo "1ClickECK.sh: calling 1ClickGCP.sh with all"
       (cd ./gcp; bash ./1ClickGCP.sh -b all $openebs_enabled)
       duration=$(( SECONDS - start ))
       echo "1ClickECK.sh: Total deployment time in seconds:" $duration
    elif [ $createmode == true ] && [ $k8sonly == true ]; then
       echo "1ClickECK.sh: calling 1ClickGCP.sh gke only"
       (cd ./gcp; bash ./1ClickGCP.sh -b gke $openebs_enabled)
       duration=$(( SECONDS - start ))
       echo "1ClickECK.sh: Total deployment time in seconds:" $duration
    elif [[ $destroy == true ]]; then
       echo "1ClickECK.sh: calling 1ClickGCP.sh destroy all"
       (cd ./gcp; bash ./1ClickGCP.sh -d)
       duration=$(( SECONDS - start ))
       echo "1ClickECK.sh: Total deployment time in seconds:" $duration
    elif [[ $destroyeck == true ]]; then
       echo "1ClickECK.sh: calling 1ClickGCP.sh destroy ECK"
       (cd ./gcp; bash ./1ClickGCP.sh -de)
       duration=$(( SECONDS - start ))
       echo "1ClickECK.sh: Total deployment time in seconds:" $duration
    else
       echo "Please submit a valid argument"
       echo "Valid arguments:"
       echo "    create"
       echo "    destroy"
    fi
elif [[ $cloud == ess ]]; then
    if [ $getClusterInfo == true ]; then
       echo "Get cluster Info"
       (cd ./ess; bash ./getClusterInfo.sh)
       duration=$(( SECONDS - start ))
    elif [ $createmode == true ] ; then
       echo "1ClickECK.sh: calling 1ClickESSDeploy.sh"
       (cd ./ess; bash ./1ClickESSDeploy.sh)
       duration=$(( SECONDS - start ))
       echo "1ClickECK.sh: Total deployment time in seconds:" $duration
    elif [[ $destroy == true ]]; then
       echo "1ClickECK.sh: calling 1ClickESSDestroy.sh destroy"
       (cd ./ess; bash ./1ClickESSDestroy.sh)
       duration=$(( SECONDS - start ))
       echo "1ClickECK.sh: Total deployment time in seconds:" $duration
    else
       echo "Please submit a valid argument"
       echo "Valid arguments:"
       echo "    create"
       echo "    destroy"
    fi
else
  echo "Not a valid cloud provider.  Use: -c aws|azure|gcp"
fi
