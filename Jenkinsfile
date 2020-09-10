node {

    stage('Git-Checkout') {
        scmInfo = checkout scm
    }

    // Static code analysis
    withCredentials([string(credentialsId: 'sonarqube-login', variable: 'sonarqubeLogin')]) {
        docker.image('sonarsource/sonar-scanner-cli').inside('--network="test"') {
            stage('Code analysis') {
                sh "sonar-scanner -Dsonar.login=${sonarqubeLogin}"
            }
        }
    }

    // I used the golang container, as my project is a simple golang project
    docker.image('golang:1.15').inside {

        // I keep it very simple here. No build logic here that is specific to the application
        // Make is the interface between jenkins and our application code.
        stage('Test') { 
            sh "make build"
        }

    }

}
