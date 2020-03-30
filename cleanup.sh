#!/bin/bash

if [ -z "$1" ]
then
      echo "Enter OCP namespace! Where resources will be recreated."
      exit
fi

# start time
date +"%H:%M:%S"

####Navigate to your
oc project $1


################ Deleting all resouces of Openshift Hackathon
oc delete all -l app=healthplanner-backend

# sleep for 5 seconds
sleep 5	
oc delete all -l app=healthplanner-frontend

# sleep for 5 seconds
sleep 5	
oc delete all -l app=mongo-healthplannerdb-36

# sleep for 5 seconds
sleep 5	
oc delete template mongodb-persistent-ocs

# sleep for 5 seconds
sleep 5	
oc delete pvc healthplannerdb

# sleep for 5 seconds
sleep 5	
oc delete all -l app=jenkins-ephemeral

# sleep for 5 seconds
sleep 5	
oc delete sa jenkins
oc delete rolebinding jenkins_edit

# sleep for 5 seconds
sleep 5	
oc delete secret 12925791-ibm-redhat-connect-pull-secret health-planner-github-repo-access-secret health-planner-github-repo-webhook-secret healthplannerdb

# sleep for 5 seconds
sleep 5	
oc delete is openjdk18-openshift

# sleep for 5 seconds
sleep 5	

# end time
date +"%H:%M:%S"

echo -e "All Hackthon Openshift resources are deleted"
