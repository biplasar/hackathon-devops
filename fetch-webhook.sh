#!/bin/bash

if [ -z "$1" ]
then
      echo "Enter OCP namespace! Where resources will be recreated."
      exit
fi

####Navigate to your
oc project $1

printf "\n\n\n"
printf "Getting Webhook URL for backend pipeline"
oc describe bc/healthplanner-backend-build-pipeline | grep webhooks | sed 's/<secret>/healthplanner/g' | sed 's/URL://g'

printf "\n\n\n"
printf "Getting Webhook URL for frontend pipeline"
oc describe bc/healthplanner-frontend-build-pipeline | grep webhooks | sed 's/<secret>/healthplanner/g' | sed 's/URL://g'

printf "\n\n\n"
printf "Getting Webhook URL for backend deployment pipeline"
oc describe bc/healthplanner-backend-deployment-pipeline | grep webhooks | sed 's/<secret>/healthplanner/g' | sed 's/URL://g'

printf "\n\n"
echo "Please configure above URLs as webhooks"

