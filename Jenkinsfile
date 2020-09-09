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
    //         sh "ls -alh"
    //     }
    // }

    // docker.image('gittools/gitversion').inside {
    //     stage('Tag-Git') { 
    //         sh " /tools/dotnet-gitversion . /output file /outputfile gitversion /showvariable SemVer"
    //         sh "ls -alh"
            
    //     }
    // }

    docker.image('debian').inside {

        // I keep it very simple here. No build logic here that is specific to the application
        // Make is the interface between jenkins and our application code.
        stage('LS') { 
            sh "wget https://github.com/GitTools/GitVersion/releases/download/5.3.7/gitversion-alpine.3.10-x64-5.3.7.tar.gz -O gitversion.tar.gz && tar -xf gitversion.tar.gz && mv gitversion /usr/local/bin/"
            sh "gitversion . /showvariable SemVer"
            sh "sleep 20"
        }

    }

    docker.image('alpine').inside {

        // I keep it very simple here. No build logic here that is specific to the application
        // Make is the interface between jenkins and our application code.
        stage('LS') { 
            sh "ls -alh"
        }

    }



    // stage('Git Push To Origin') {

    //     stage('Git-Tag') { 

    //         withCredentials([usernamePassword(credentialsId: your_credentials, passwordVariable: 'GIT_PASSWORD', usernameVariable: 'GIT_USERNAME')]) {


    //             sh "git tag ${your_tag}"
    //             sh "git push https://${GIT_USERNAME}:${GIT_PASSWORD}@${repository} ${your_tag}"
    //         }
    //     }
    // }



    // Static code analysis
    withCredentials([string(credentialsId: 'sonarqube-login', variable: 'sonarqubeLogin')]) {
        docker.image('sonarsource/sonar-scanner-cli').inside('--network="test"') {
            stage('Code analysis') {
                sh "sonar-scanner -Dsonar.login=${sonarqubeLogin}"
            }
        }
    }

    // stage('Upload-To-Github-Releases') { 
    //     sh "echo Uploader to github"
    // }
}
