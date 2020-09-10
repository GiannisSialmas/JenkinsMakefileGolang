node {

    stage('Git-Checkout') {
        scmInfo = checkout scm
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
        stage('Test') { 
            sh "make compile-platforms"
        }
    }

    // This stops at icu
    docker.image('ubuntu:18.04').inside {
        stage('Tag-Git') {
            sh "apt update"
            sh "apt install -y wget libunwind8 icu-devtools"
            sh "wget https://github.com/GitTools/GitVersion/releases/download/5.3.7/gitversion-ubuntu.18.04-x64-5.3.7.tar.gz -O gitversion.tar.gz && tar -xf gitversion.tar.gz && mv gitversion /usr/local/bin/"
            sh "ls -alh"
            sh "gitversion"
        }
    }

    // This stops at icu error
    // docker.image('alpine').inside {
    //     stage('Tag-Git') {
    //         sh "apk update"
    //         sh "apk add --no-cache libstdc++ libintl libcurl"
    //         sh "wget https://github.com/GitTools/GitVersion/releases/download/5.3.7/gitversion-alpine.3.10-x64-5.3.7.tar.gz -O gitversion.tar.gz && tar -xf gitversion.tar.gz && mv gitversion /usr/local/bin/"
    //         sh "ls -alh"
    //         sh "gitversion"
    //     }
    // }


    //TODO: A good practice here would be a have a utility docker image built beforehand, and use it here
    //TODO: Include this in a groovy common library with arguments the release name, commit sha, tag and repo.
    withCredentials([string(credentialsId: 'github-access-token', variable: 'githubAccessToken')]) {
        docker.image('alpine').inside {
            stage('Upload binaries') {
                // Download the github release binary. 
                sh "wget https://github.com/buildkite/github-release/releases/download/v1.0/github-release-linux-amd64 -O githubRelease"
                sh "chmod u+x ./githubRelease"
                githubRepo=scmInfo.GIT_URL.minus("https://github.com/").minus(".git")
                sh "./githubRelease 'JenkinsMakefileGolang 1.0.${currentBuild.number}' bin/* --commit '${scmInfo.GIT_COMMIT}' --tag '1.0.${currentBuild.number}' --github-repository '${githubRepo}' --github-access-token ${githubAccessToken}"
            }
        }
    }


}
