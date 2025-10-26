pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                echo '📥 Checking out source code...'
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                echo '🐳 Building Docker image...'
                sh 'docker compose build'
            }
        }

        stage('Deploy Container') {
            steps {
                echo '🚀 Starting containers...'
                sh 'docker compose up -d'
            }
        }
        stage('Jenkins Github') {
            steps {
                echo 'Hallo saya success'
            }
        }
    }
}


