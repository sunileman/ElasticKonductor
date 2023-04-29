#!/bin/bash
##deletes ebs volumes.  This happens when gp3 is used as storage type and terraform does not delete the volumes
clusternameraw=$(cd ../eks/; terraform output cluster_name)
clustername=${clusternameraw//\"/}

echo $clustername
python delete-ebs-volumes.py $clustername