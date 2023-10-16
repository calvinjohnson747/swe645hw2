pipeline {
    agent any
    tools{
        maven '3.9.5'
    }
    environment {
        DOCKER_HUB_CREDENTIALS = credentials('DockerHub_ID') // Update with your Docker Hub credentials ID
        GIT_REPO = 'https://github.com/calvinjohnson747/swe645hw2.git' // Update with your GitHub repository URL
        DOCKER_IMAGE_NAME = 'calvinjohnson747/swe645hw2-image'
        TIMESTAMP = new Date().format('yyyyMMdd-HHmmss')
        KUBE_CONFIG = credentials('kubeconfig')
        
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
    
            stage('Build Docker Image') {
                steps {
                    script {
                        // Build and tag the Docker image
                        def dockerImage = "${DOCKER_IMAGE_NAME}:${TIMESTAMP}"
                        sh "docker build -t ${dockerImage} ."
                       
                        }
                    }
                }
            
        stage('Push Docker Image to Docker Hub') {
            steps {
                script {
                    def dockerImage = "${DOCKER_IMAGE_NAME}:${TIMESTAMP}"

                    // Docker login
                    sh "docker login -u calvinjohnson747 -p Cjjjjj123#"

                    // Push the Docker image to Docker Hub
                    sh "docker push ${dockerImage}"

                    }
                }
            }
        

        stage('Update Kubernetes Deployments') {
            steps {
                script {
                    withCredentials([file(credentialsId: 'kubeconfig', variable: 'KUBE_CONFIG')]) {
                        sh "kubectl set image deployment/tomcat-deployment tomcat-container=${DOCKER_IMAGE_NAME}"
                    }
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
