#!/bin/bash
if [ -z "$1" ]
then
      echo "Github username is mandatory! Please pass it as first argument."
      exit
fi

if [ -z "$2" ]
then
      echo "GITHUB Personal Access Token is mandatory! Please pass it as second argument."
      exit

fi

if [ -z "$3" ]
then
      echo "Enter OCP namespace! Where resources will be recreated."
      exit

fi

# start time
date +"%H:%M:%S"


#######Goto your respective namespace
oc project $3

#####Creating Jenkins Ephimeral instance
oc new-app jenkins-ephemeral

# sleep for 5 seconds
sleep 5


#####Creating Mongodb persistent database
oc create -f ocs-mongodb-perst.yaml


# sleep for 10 seconds
sleep 10

oc new-app --name=mongo-healthplannerdb-36 --template=mongodb-persistent-ocs \
							-p MONGODB_USER=root -p MONGODB_PASSWORD=root \
							-p MONGODB_DATABASE=healthplannerdb \
							-p MONGODB_ADMIN_PASSWORD=admin \
							-p DATABASE_SERVICE_NAME=healthplannerdb
							
# sleep for 15 seconds
sleep 15							


####### Create generic secret for code fetch within pipeline
oc create secret generic health-planner-github-repo-access-secret --from-literal username=$1 --from-literal password=$2
oc annotate secret health-planner-github-repo-access-secret build.openshift.io/source-secret-match-uri-1=https://github.com/rito206868/*
						

#####Create RedHat secret to use latest images for build from RedHat registries
oc create -f 12925791_ibm-redhat-connect-secret.yaml

# sleep for 5 seconds
sleep 5

####Attach the secret respective servicecoounts
oc secrets link default 12925791-ibm-redhat-connect-pull-secret --for=pull
oc secrets link builder 12925791-ibm-redhat-connect-pull-secret --for=pull
oc secrets link jenkins 12925791-ibm-redhat-connect-pull-secret --for=pull

#####Creating image stream for Java S2I build image
oc import-image redhat-openjdk-18/openjdk18-openshift --from=registry.access.redhat.com/redhat-openjdk-18/openjdk18-openshift --confirm

# end time
date +"%H:%M:%S"
