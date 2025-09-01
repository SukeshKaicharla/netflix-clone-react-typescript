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
                    docker build -t netflix-clone:latest -f /var/lib/jenkins/workspace/netflix-clone-react-typescript/Dockerfile /var/lib/jenkins/workspace/netflix-clone-react-typescript
                '''
            }
        }

        stage('Run Docker Container') {
            steps {
                sh '''
                    docker rm -f netflix-clone || true
                    docker run -d --name netflix-clone -p 3000:8080 netflix-clone:latest
                '''
            }
        }
    }
}
