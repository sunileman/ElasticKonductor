#!/bin/bash
var1=$(grep lbname $"./terraform.tfvars" | awk -F= '{print $2}')
lb1=`sed -e 's/^"//' -e 's/"$//' <<<"$var1"`

var3=$(grep lb2name $"./terraform.tfvars" | awk -F= '{print $2}')
lb2=`sed -e 's/^"//' -e 's/"$//' <<<"$var3"`


regionraw=$(grep resource_group_location $"./terraform.tfvars" | awk -F= '{print $2}')
region=`sed -e 's/^"//' -e 's/"$//' <<<"$regionraw"`

echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo Checking if license file is exists
echo ...
echo ...
if test -f ./license/es-license.json; then
  echo License file found and should have been applied to ECK
else
  echo No license file found. Make sure it is named es-license.json and placed under ./create-eck/license
  echo Basic license applied.
fi
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo ES URL[IP]: https://$(kubectl get service eck-external-es-http | tail -n -1 | awk {'print $4"" '}):9200
echo or
echo ES URL[DNS]: https://$lb2.$region.cloudapp.azure.com:9200
echo
echo Kibana URL[IP]: https://$(kubectl get service eck-kb-http | tail -n -1 | awk {'print $4"" '}):5601
echo or
echo Kibana URL[DNS]: https://$lb1.$region.cloudapp.azure.com:5601
echo
echo Kibana UserName: elastic
echo Kibana Password: $(kubectl get secret eck-es-elastic-user -o=jsonpath='{.data.elastic}' | base64 --decode)
echo PLEASE NOTE: It may take a few minutes for the kibana UI to come up
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
