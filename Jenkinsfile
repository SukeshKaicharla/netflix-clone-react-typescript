pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/SukeshKaicharla/netflix-clone-react-typescript.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                    docker rmi -f netflix-clone:latest || true
                    docker build -t netnetflix-clone:latest .
                '''
            }
        }

        stage('Run Docker Container') {
            steps {
                sh '''
                    docker stop netflix-clone || true
                    docker rm netflix-clone || true
                    docker run -d --name netflix-clone -p 3000:8080 netflix-clone:latest
                '''
            }
        }
    }
}
