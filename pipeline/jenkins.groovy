pipeline {
agent any
    environment {
        REPO = 'https://github.com/vsk44/kbot'
        BRANCH = 'main'
    }
    parameters {
        choice(name: 'OS', choices: ['linux', 'darwin', 'windows', 'all'], description: 'Pick OS')
        choice(name: 'ARCH', choices: ['amd64','arm64'], description: 'Pick ARCH')
    }
    stages {
        
        stage("clone") {
            steps {
                echo 'CLONE REPOSITORY'
                    git branch: "${BRANCH}", url: "${REPO}"
            }
        }
        
        stage("test") {
            steps {
                echo 'TEST EXECUTION STARTED'
                sh 'make test'
            }
        }
        
        stage("build") {
            steps {
                echo "Build for platform ${params.OS}"
                echo "Build for arch: ${params.ARCH}"
                sh "make build TARGETOS=${params.OS} TARGETARCH=${params.ARCH}"
            }
        }
        
        stage("image") {
            steps {
                script {
                    echo 'IMAGE EXECUTION STARTED'
                    sh "make image TARGETOS=${params.OS} TARGETARCH=${params.ARCH}"
                }
            }
        }
        
        stage("push") {
            steps {
                script {
                    docker.withRegistry('','dockerhub') {
                    sh "make push TARGETOS=${params.OS} TARGETARCH=${params.ARCH}"
                    }
                }
            }
        }
    }
}