pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                git 'https://github.com/bitu-kumar1269/optimize-app.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t bitukumar/optimize-app:v1 .'
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'bitukumar',
                    passwordVariable: 'DOCKER_PASSWORD'
                )]) {
                    sh '''
                    echo $DOCKER_PASSWORD | docker login -u bitukumar --password-stdin
                    docker push bitukumar/optimize-app:v1
                    '''
                }
            }
        }

        stage('Run Container') {
            steps {
                sh '''
                docker rm -f optimize-app || true
                docker run -d -p 3006:3006 --name optimize-app bitukumar/optimize-app:v1
                '''
            }
        }
    }
}