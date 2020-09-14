# Application
My application is a very simple golang program which prints a greeting. It is contained in `src/main.go` and it's tests are in `src/main_test.go`. Even though the logic is very simple and no external packages were needed, i added one so that it better emulates a production application, and included the package installation inside the Makefile.
       
# Requirements:
## Jenkins infra should be used.
Jenkins is setup with docker compose. I used volumes to keep the jenkins home folder even after deleting the jenkins container by accident, and to bind-mount the Docker socket and binary("Docker-out-of-Docker")
## The project/code should be stored in an external SCM (git based).
I used github. 
## Build should be done using Makefile.
The make file has a build target, which installs the dependencies, runs the tests and compiles the code to a binary.
## Build configuration should be given as Jenkinsfile (scripted pipeline preferably).
Done 
##  CI pipeline should be triggered for all branches (master, feature) when a change is committed there.
I setup a jenkins server in Digital Ocean with a public ip and a webhook in github on push events.
On the Jenkins side, i allowed `GitHub hook trigger for GITScm polling` to trigger builds by the webhook.
In `Branches to build` i added two `Branch Specifiers`: `*/master` and `*/feature**`
 
# Bonus points 1:
## Use a Docker host to dynamically provision a docker container as a Jenkins agent node, let that run a single build, then tear down that node, without the build process (or Jenkins job definition) requiring any awareness of docker.
The docker plugin is used to dynamically provision a docker container as a Jenkins agent node.
The Docker socket and binary are bind-mounted via docker volumes("Docker-out-of-Docker")
The jenkins job configuration does not interact directly with the docker binary. The docker.image('golang:1.15').inside directive is used to provide the execution environment for our build stage.

# Bonus points 2:
The SonarQube is spinned up, as described inside the docker-compose file.
It exposes the 9000 port so that we can access the ui from our browser, and also uses a `test` external network we have created manually, so that the code scanner container which will be spinned up later can communicate with SonarQube.
The setup is done with the Embedded database used for testing and POCs. As a result, we lose our data when the container is removed.

## Install(docker) a local instance of SonarQube and run analysis on your project.
To do the static code analysis with the SonarQube scanner manually, a bash script was created which spins up the SonarQube scanner inside the preexisting `test` network. We mount our application code inside the scanner with a volume in /usr/src/. After the scanner completes the static code analysic, it sends the report to the sonarqube container via the test network we configured earlier.

There are 2 ways to configure the runner. The first one is via a sonar-project.properties file in the root folder of our project. This is easy to implement but we expose sensitive information about the SonarQube login.
The second way it to pass the configuration information to the code scanner via env variables. This is safer as we can keep the login info as secrets in our Jenkins instance and unlock them during the pipeline run for consumption.

## Add code analysis as stage in the CI pipeline.
We use the docker.image('sonarsource/sonar-scanner-cli').inside('--network="test"') to spin up the static code analysis scanner docker image inside our test network, in which our SonarQube instance also exists.
We then pass the sensitive info by unlocking the login secrets from the credentials plugin and pass it to the sonar-scanner command

A better way to do this is with sonar cloud if there not other requirenments that block us.


# Extras
## Upload binaries to hithub releases
An alpine docker image is used as a base in which the github-release package is downloaded in order to upload the binaries to github releases.
The github access token is unlocked from the credentials plugin and used in the command.

The build number is used to generate the tag as the actual tagging mechanism has not been implemented yet. 
