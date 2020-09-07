node {
    stage('Git-Checkout') {
        scmInfo = checkout scm
    }
    stage('Test') { 
        sh "make test"
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
