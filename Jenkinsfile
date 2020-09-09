node {

    stage('Git-Checkout') {
        scmInfo = checkout scm
    }

    // I used the golang container, as my project is a simple golang project
    docker.image('golang:1.15').inside {

        // I keep it very simple here. No build logic here that is specific to the application
        // Make is the interface between jenkins and our application code.
        stage('Test') { 
            sh "make build"
        }

    }

    //Output results to file and parse it in next step.
    // Generate tag, git-tag and push to remote
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

    // Static code analysis
    withCredentials([string(credentialsId: 'sonarqube-login', variable: 'sonarqube-login')]) {
        docker.image('sonarsource/sonar-scanner-cli').inside('--network="test"') {
            stage('Code analysis') {
                sh "sonar-scanner -Dsonar.login=${sonarqube-login}"
            }
        }
    }

    // stage('Upload-To-Github-Releases') { 
    //     sh "echo Uploader to github"
    // }
}
