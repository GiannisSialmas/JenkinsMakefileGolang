node {
    stage('Git-Checkout') {
        scmInfo = checkout scm
    }

    docker.image('golang:1.15').inside {
        stage('Install-Make') { 
            sh "apt update && apt install -y build-essential"
        }
        stage('Test') { 
            sh "make test"
        }
        stage('Build') { 
            sh "make compile"
        }
    }

    docker.image('alpine').inside {
        stage('Tag-Git') {
            sh "wget https://github.com/GitTools/GitVersion/releases/download/5.3.7/gitversion-alpine.3.10-x64-5.3.7.tar.gz -O gitversion.tar.gz && tar -xf gitversion.tar.gz && mv gitversion /usr/local/bin/"
            gitTag = sh (
                script: "gitversion /output json /showvariable SemVer",
                returnStdout: true
            ).trim()
            echo "Git Tag is ${gitTag}"
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
