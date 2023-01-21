#!/bin/bash
#echo lbname="$(terraform output lbname)" > ../lbname.tfvars
var1=$(terraform output lbname)
sed -i "/^lbname/s/=.*$/=$var1/" ../terraform.tfvars


var2=$(terraform output lb2name)
sed -i "/^lb2name/s/=.*$/=$var2/" ../terraform.tfvars
