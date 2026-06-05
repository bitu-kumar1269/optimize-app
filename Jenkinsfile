pipeline {
    agent any

    stages {

        stage('Build Docker Image') {
            steps {
                sh '/usr/local/bin/docker build -t bitukumar/optimize-app:v1 .'
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh '''
                    echo $DOCKER_PASS | /usr/local/bin/docker login -u $DOCKER_USER --password-stdin
                    /usr/local/bin/docker push bitukumar/optimize-app:v1
                    '''
                }
            }
        }

        stage('Run Container') {
            steps {
                sh '''
                /usr/local/bin/docker rm -f optimize-app || true
                /usr/local/bin/docker run -d -p 3006:3006 --name optimize-app bitukumar/optimize-app:v1
                '''
            }
        }
    }
}