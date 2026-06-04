pipeline {
    agent any

    stages {

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t bitukumar/optimize-app:v1 .'
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASSWORD'
                )]) {
                    sh '''
                    echo $DOCKER_PASSWORD | docker login -u $DOCKER_USER --password-stdin
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