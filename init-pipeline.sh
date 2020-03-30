#!/bin/bash

if [ -z "$1" ]
then
      echo "Enter OCP namespace! Where resources will be recreated."
      exit
fi

####Navigate to your
oc project $1

####Creating pipeline build configs for backend and frontend applications

# sleep for 5 seconds
sleep 5	
oc process -f backend-pipeline-template.yaml --param-file backend.properties | oc apply -f -

# sleep for 5 seconds
sleep 5	
oc process -f frontend-pipeline-template.yaml --param-file frontend.properties | oc apply -f -

