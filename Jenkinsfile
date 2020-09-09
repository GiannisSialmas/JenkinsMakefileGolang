node {


    docker.image('golang:1.15').inside {
        stage('Install dependencies') {
            sh "apt update && apt install -y build-essential"
            // sh "wget https://github.com/GitTools/GitVersion/releases/download/5.3.7/gitversion-debian.9-x64-5.3.7.tar.gz -O gitversion.tar.gz && tar -xf gitversion.tar.gz && mv gitversion /usr/local/bin/"
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


    // stage('Tag-Git') { 

    // }
    // stage('Tag-Artifact') { 
    //     sh "mv bin/main bin/main-$(gitversion | jq -r \".SemVer\")"
    // }
    // stage('Upload-To-Bitbucket') { 
    //     sh "echo Uploader to github"
    // }
}
