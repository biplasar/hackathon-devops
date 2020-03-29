#!/bin/bash
oc project ritac041-in
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

