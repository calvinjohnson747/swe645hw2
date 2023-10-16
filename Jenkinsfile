pipeline {
    agent any
    
    environment {
        DOCKER_HUB_CREDENTIALS = credentials('DockerHub_ID') // Update with your Docker Hub credentials ID
        GIT_REPO = 'https://github.com/calvinjohnson747/swe645hw2.git' // Update with your GitHub repository URL
        MAVEN_PROJECT_PATH = 'project1_2/src/mavenproject1-1.0-SNAPSHOT.war'
        DOCKER_IMAGE_NAME = 'calvinjohnson747/hw2-image'
    }
    
    stages {
        stage('Clone Repository and Build WAR') {
            steps {
                script {
                    git url: GIT_REPO
                    sh 'mvn clean package'
                }
            }
        }

        stage('Tag Docker Image') {
            steps {
                script {
                    def timestamp = new Date().format('yyyyMMdd-HHmmss')
                    def dockerImage = "${DOCKER_IMAGE_NAME}:${timestamp}"
                    docker.withRegistry('https://registry.hub.docker.com', DOCKER_HUB_CREDENTIALS) {
                        sh "docker build -t ${dockerImage} ."
                        sh "docker tag ${dockerImage} ${DOCKER_IMAGE_NAME}:latest"
                    }
                }
            }
        }

        stage('Push Docker Image to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', DOCKER_HUB_CREDENTIALS) {
                        sh "docker push ${DOCKER_IMAGE_NAME}:${timestamp}"
                        sh "docker push ${DOCKER_IMAGE_NAME}:latest"
                    }
                }
            }
        }

        stage('Update Kubernetes Deployments') {
            steps {
                script {
                    def timestamp = new Date().format('yyyyMMdd-HHmmss')
                    sh "kubectl set image deployment/tomcat-deployment tomcat-container=${DOCKER_IMAGE_NAME}:${timestamp} --all"
                }
            }
        }
    }
    
    post {
        success {
            echo 'Jenkins Pipeline executed successfully!'
        }
        failure {
            echo 'Jenkins Pipeline failed!'
        }
    }
}
