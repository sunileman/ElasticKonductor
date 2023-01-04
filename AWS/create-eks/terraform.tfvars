####THIS section of variables are REQUIRED.  They must be set for 1Click to run


##house keeping tag.  Set please
tags = {
    "Owner" = "sunile.manjee@.co"
    "KeepAliveUntil" = "12312022"
    "username" = "sunman" #This can be anything you call yourself
}

#Set aws secret and key as env variables.  
#Optionally both values can be set here
#aws_access_key=some_value
#aws_secret_key=some_value

##es verison
es_version="8.5.3"

##eks version. Using default and hence commenting out...
##eks_version=1.24

#what region should this be deployed in
region = "us-east-1"

#set vpc_id if you bring your own vpc and subnets.  Single vpc with 2 public subnets is common.
##this can also be set as env variable
#vpc_id = ""


##YOUR IP so you can reach kibana.  Also can be set as env variable
#set to 0.0.0.0/0 if you want to expose to entire internet
#client_access_cidr = ["x.x.x.x/32"]


################################################################################################################
################################################################################################################
################################################################################################################
###This section list out some of the variables.  Full list is in variables.tf.
##If commented out, it will take the defaults from variables.tf.
##Please don't change values in variables.tf.  INSTEAD bring the variable here and set it what you desire



#master_instance_type = ["m6g.large"]
#master_instance_count = 1

#hot_instance_type = ["m6g.large"]
#hot_instance_count = 1

#warm_instance_type = ["m6g.large"]
#warm_instance_count = 1

#frozen_instance_type = ["m6g.large"]
#frozen_instance_count = 1

#ml_instance_type = ["m6g.large"]
#ml_instance_count = 1
