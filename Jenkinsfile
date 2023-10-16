pipeline {
    agent any
    stages {
    stage('Clone Repository and Build WAR') {
            steps {
                script {
                    git url: GIT_REPO
                    sh 'mvn clean package'
                }
            }
        }
        stage('Build Docker image') {
            steps {
                sh 'docker build -t calvinjohnson747/hw2-image .'
            }
        }
        stage('Login to Docker Hub') {
            steps {
                sh 'docker login -u calvinjohnson747 -p Cjjjjj123#'
            }
        }
        stage('Push Docker image') {
            steps {
                sh 'docker push calvinjohnson747/hw2-image'
            }
        }
        
        stage('Restart deployment') {
            steps {
                sh 'kubectl rollout restart deployment/tomcat-deployment'
            }
        }
    }
}
