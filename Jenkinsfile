node {
    stage('Git-Checkout') {
        scmInfo = checkout scm
    }
    stage('Test') { 

        // docker.image('golang:1.15').inside {
        //     sh "make test"
        // }

        docker.image('golang:1.15').inside {
            sh "go test ./src"
        }

    }
    stage('Build') { 
        sh "make build"
    }
    stage('Tag-Git') { 
		gitTag = sh (
			script: """#!/bin/bash
			gitversion | jq -r \".SemVer\"
			""",
			returnStdout: true
		).trim()
        echo "Git Tag is ${gitTag}"
    }
    // stage('Tag-Artifact') { 
    //     sh "mv bin/main bin/main-$(gitversion | jq -r \".SemVer\")"
    // }
    // stage('Upload-To-Bitbucket') { 
    //     sh "echo Uploader to github"
    // }
}
