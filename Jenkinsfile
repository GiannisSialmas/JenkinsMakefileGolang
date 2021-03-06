node {

    stage('Git-Checkout') {
        scmInfo = checkout scm
        println "scmInfo.BRANCH_NAME is: ${scmInfo.GIT_BRANCH}"
    }

    // Static code analysis
    //TODO: Only do it inside the pipeline manually if there are compliance reasons. Else do this with sonarcloud.
    withCredentials([string(credentialsId: 'sonarqube-login', variable: 'sonarqubeLogin')]) {
        docker.image('sonarsource/sonar-scanner-cli').inside('--network="test"') {
            stage('Code analysis') {
                sh "sonar-scanner -Dsonar.login=${sonarqubeLogin}"
            }
        }
    }

    // I used the golang container, as my project is a simple golang project
    docker.image('golang:1.15').inside {
        // I keep it very simple here. No build logic that is specific to the application
        // Make is the interface between jenkins and our applications' code.
        stage('Install-deps-test-compile') { 
            sh "make compile-platforms"
        }
    }

    // This stops at icu
    docker.image('ubuntu:18.04').inside {
        stage('Get-FullSemVer-And-SemVer') {
            sh "apt update"
            sh "apt install -y wget libunwind8 icu-devtools"
            sh "wget https://github.com/GitTools/GitVersion/releases/download/5.3.7/gitversion-ubuntu.18.04-x64-5.3.7.tar.gz -O gitversion.tar.gz && tar -xf gitversion.tar.gz && mv gitversion /usr/local/bin/"

            semVer = sh (
                script: """#!/bin/bash
                gitversion /output json /showvariable SemVer
                """,
                returnStdout: true
            ).trim()
            println "semVer is: ${semVer}"


        }
    }

    //TODO: A good practice here would be a have a utility docker image built beforehand, and use it here
    //TODO: Include this in a groovy common library with arguments the release name, commit sha, tag and repo.
    // This can also be done with curl, but it's not so user friendly, and we also dont have to study the api.
    // Also the binary releases are going to keep up with api changes, if and when they happen.
    withCredentials([string(credentialsId: 'github-access-token', variable: 'githubAccessToken')]) {
        docker.image('alpine').inside {
            stage('Upload binaries') {
                // Download the github release binary. 
                sh "wget https://github.com/buildkite/github-release/releases/download/v1.0/github-release-linux-amd64 -O github-release"
                sh "chmod u+x ./github-release"
                githubRepo=scmInfo.GIT_URL.minus("https://github.com/").minus(".git")
                
                // Figure out if this a master or a feature branch and act accordingly
                preReleaseFlagEnabled = "${scmInfo.GIT_BRANCH.endsWith('master') ? '' : '--prerelease'}"
                sh "./github-release 'JenkinsMakefileGolang ${semVer}' bin/* --commit '${scmInfo.GIT_COMMIT}' --tag '${semVer}' ${preReleaseFlagEnabled} --github-repository '${githubRepo}' --github-access-token ${githubAccessToken}"
            }
        }
    }


}
