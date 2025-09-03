pipeline {
    agent any

    environment {
        WORK_DIR = "/var/lib/jenkins/workspace/netflix"
        IMAGE_NAME = "netflix-clone"
        IMAGE_TAG  = "latest"
        CONTAINER_NAME = "netflix-container"
        PORT = "3000"   // React app default port
    }

    stages {
        stage('Checkout Code') {
            steps {
                    git branch: 'main', url: 'https://github.com/yuvakishor123/netflix-clone-react-typescript.git'
                }
            }


        stage('Build Docker Image') {
            steps {
                    sh '''
                        docker rmi -f ${IMAGE_NAME}:${IMAGE_TAG} || true
                        docker build -t ${IMAGE_NAME}:${IMAGE_TAG} -f ${WORK_DIR}/Dockerfile ${WORK_DIR}
                    '''
                }
        }

        stage('Run Docker Container') {
            steps {
                    sh '''
                        docker rm -f ${CONTAINER_NAME} || true
                        docker run -d --name ${CONTAINER_NAME} -p 3000:8080 ${IMAGE_NAME}:${IMAGE_TAG}
                    '''
            }
        }
    }
}
