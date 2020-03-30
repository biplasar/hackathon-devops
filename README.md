# This Read.Me file explains how this devops stack would work step-by-step on any OCP platform

### Participating GitHub Repositories which is part of this DevOps process

```
* https://github.com/rito206868/healthplanner.git --Beckend code on Java-SpringBoot
* https://github.com/rito206868/patientInformationApp.git  --Frontend code on AngularJS
                                                             Please check the docker file for application 
                                                             folder name and update accordingly
```

* From backend code take the "build" folder, Dockerfile and pom.xml, as these have configurations needed
* From frontend code take the "build" folder, "nginx" folder and the Dockerfile which are created for this DevOps pipelines.
* I have used S2I strategy for backend and Docker Strategy for frontend.

Note: Above applications are just reference, any app with required configurations can be used.

### Update below properties before we begin

```
* backend.properties --- It has backend related codebase repo, branch, OCP namespace and this DevOps repo
* frontend.properties --- It has frontend related codebase repo, branch, OCP namespace and this DevOps repo
```

### Checkout this DevOps repo and execute following script one-by-one

* Following script will create all necessary components and services before we begin code build and deployment
```
$> ./setup.sh <GitHub_Username> <GitHub_Personal_Token> <OCP_Namespace> <Git_URL>
EXAMPLE: ./setup.sh rito206868 clkajdlkewqjd3284798247298 ritac041-in https://github.com/rito206868/*
```

* Following script will create necessary pipelines for both frontend and backend application build and deployment
```
$> ./init-pipeline.sh <OCP_Namespace>
EXAMPLE: ./init-pipeline.sh ritac041-in
```

* Following script will print all Webhooks which are created through build-config in OCP. These webhooks needs to be 
Configured in respective repositories in GitHub
```
$> ./fetch-webhook.sh <OCP_Namespace>
EXAMPLE: ./fetch-webhook.sh ritac041-in
```

* Following script will delete all components created by this stack
```
$> ./cleanup.sh <OCP_Namespace>
EXAMPLE: ./cleanup.sh ritac041-in
```

***Note: Once applications are up and ready, developer needs to update respective API Url in Frontend , as well as DB config and then
checkin the code. Pipelines will be triggered automatically.

***Note: At present automatic trigger for config change on deployment is disabled we need to push the deployment button to trigger
the pipeline.


