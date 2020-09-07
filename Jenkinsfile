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

    docker.image('tboeker/gitversion').inside {
        stage('Tag-Git') { 
            gitTag = sh (
                script: "git-version /?",
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
