node {


    docker.image('golang:1.15').inside {
        stage('Install dependencies') {
            sh "apt update && apt install -y build-essential"
        }
        stage('Git-Checkout') {
            scmInfo = checkout scm
        }
        stage('Test') { 
            sh "make test"
        }
        stage('Build') { 
            sh "make compile"
        }
    }

    //Output results to file and parse it in next step.
    // docker.image('gittools/gitversion:5.3.8-linux-alpine.3.10-x64-netcoreapp3.1').inside {
    //     stage('Tag-Git') { 
    //         sh "apk update"
    //         sh "apk add git"
    //         gitTag = sh (
    //             script: "/tools/dotnet-gitversion . /output json /showvariable SemVer",
    //             returnStdout: true
    //         ).trim()
    //         echo "Git Tag is ${gitTag}"
    //     }
    // }

    docker.image('sonarsource/sonar-scanner-cli').inside { c ->
        stage('Print container id') { 
            println "docker id is: ${c.id}"
        }
    }

    docker.image('sonarsource/sonar-scanner-cli').inside {
        stage('Check code') { 

        }
    }
    // stage('Tag-Git') { 

    // }
    // stage('Tag-Artifact') { 
    //     sh "mv bin/main bin/main-$(gitversion | jq -r \".SemVer\")"
    // }
    // stage('Upload-To-Bitbucket') { 
    //     sh "echo Uploader to github"
    // }
}
