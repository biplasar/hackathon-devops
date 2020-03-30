#!/bin/bash

if [ -z "$1" ]
then
      echo "Enter OCP namespace! Where resources will be recreated."
      exit
fi

oc project ritac041-in
oc process -f backend-pipeline-template.yaml --param-file backend.properties | oc apply -f -
oc process -f frontend-pipeline-template.yaml --param-file frontend.properties | oc apply -f -

