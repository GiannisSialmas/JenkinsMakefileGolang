# Requirements:
## Jenkins infra should be used.
Done 
## The project/code should be stored in an external SCM (git based).
Done 
## Build should be done using Makefile.
Done 
## Build configuration should be given as Jenkinsfile (scripted pipeline preferably).
Done 
##  CI pipeline should be triggered for all branches (master, feature) when a change is committed there.
This needs a public instance of Jenkins with public ip)

# Bonus points 1:
## Use a Docker host to dynamically provision a docker container as a Jenkins agent node, let that run a single build, then tear down that node, without the build process (or Jenkins job definition) requiring any awareness of docker.
Expain plugin and directives in 
What does this mean without the build process (or Jenkins job definition) requiring any awareness of docker

# Bonus points 2:
## Install(docker) a local instance of SonarQube and run analysis on your project.
TODO
## Add code analysis as stage in the CI pipeline.
TODO