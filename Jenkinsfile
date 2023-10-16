pipeline {
    agent any
    
    stages {
        stage('Hello World') {
            steps {
                echo 'Hello World!'
            }
        }
        
        // Add more stages as needed for your actual build and deployment steps
        // For testing, you can keep it simple with just the 'Hello World' stage.
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
