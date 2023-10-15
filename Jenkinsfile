pipeline{
  agent any
  environment{
    DOCKERHUB_PASS = credentials('Cjjjjj123#')
  }
  stages{
    stage("Building the Student Survey Image"){
      steps{
        script{
          checkout scm
          sh 'rm -rf *.war'
          sh 'jar -cvf mavenproject1-1.0-SNAPSHOT.war -C WebContent/ .'
          sh 'echo ${BUILD_TIMESTAMP}'
          sh "docker login -u calvinjohnson747 -p ${Cjjjjj123#}"
          def customImage = docker.build("calvinjohnson747/hw2-image:${BUILD_TIMESTAMP}")
        }
      }
      stage("Pushing Image on DockerHub"){
        steps{
          script{
            sh 'docker push calvinjohnson747/hw2-image:${BUILD_TIMESTAMP}'
          }
        }
      }
      stage("Deploying to Rancher as single pod"){
        steps{
          sh 'kubectl set image deployment/studentsurvey-pipeline studentsurvey-pipeline=calvinjohnson747/hw2-image:${BUILD_TIMESTAMP} -n jenkins-pipeline'
        }
      }
      stage("Deploying to Rancher with load balancer"){
        steps{
          sh 'kubectl set image deployment/studentsurvey-pipeline2 studentsurvey-pipeline2=calvinjohnson747/hw2-image:${BUILD_TIMESTAMP} -n jenkins-pipeline'
        }
      }
    }
  }
