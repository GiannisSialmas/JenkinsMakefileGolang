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
The sonarqube is spinned up, as described inside the docker-compose file.
It exposes the 9000 port so that we can access the ui from our browser, and also uses a test external network we have created manually, so that the code scanner container which will be spinned up later can communicate with sonarquke.
The setup is done at first with the Embedded database for testing. As a result, we lose our data when the container is removed.
To do the analysis with the sonarqube runner manually, a bash script was created which spins up the sonarquke runner inside the preexisting test network. We mount our application code inside the runner, and we configure the runner via a `sonar-project.properties` file inside the root of our source code. After the runner completes the code check, it sends the report to the sonarqube instance
## Add code analysis as stage in the CI pipeline.
TODO