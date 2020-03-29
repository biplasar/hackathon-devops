#!/bin/bash
oc project ritac041-in
oc process -f backend-pipeline-template.yaml --param-file backend.properties | oc apply -f -
oc process -f frontend-pipeline-template.yaml --param-file frontend.properties | oc apply -f -

