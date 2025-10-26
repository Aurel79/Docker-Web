pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out source code...'
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                script {
                    // Gunakan tag unik (misalnya pakai BUILD_NUMBER)
                    dockerImage = docker.build("calculator-app:${env.BUILD_NUMBER}")
                }
            }
        }

        stage('Run Container') {
            steps {
                echo 'Running container on port 8090...'
                script {
                    // Pastikan tidak ada container sebelumnya yang masih jalan
                    sh '''
                        docker ps -q --filter "ancestor=calculator-app:${BUILD_NUMBER}" | xargs -r docker stop
                        docker ps -aq --filter "ancestor=calculator-app:${BUILD_NUMBER}" | xargs -r docker rm
                    '''
                    sh 'docker run -d -p 8090:8090 --name calculator-app calculator-app:${BUILD_NUMBER}'
                }
            }
        }
    }

    post {
        success {
            echo '✅ Pipeline completed successfully!'
        }
        failure {
            echo '❌ Pipeline failed.'
        }
        always {
            echo 'Cleaning up...'
        }
    }
}
