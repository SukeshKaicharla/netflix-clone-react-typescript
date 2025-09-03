pipeline {
    agent any

    environment {
        WORK_DIR        = "${env.WORKSPACE}"
        IMAGE_NAME      = "netflix-clone"
        IMAGE_TAG       = "latest"
        CONTAINER_NAME  = "netflix-container"
        HOST_PORT       = "3000"   // host port where you want to access app
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
                    docker run -d --name ${CONTAINER_NAME} -p ${HOST_PORT}:80 ${IMAGE_NAME}:${IMAGE_TAG}
                '''
            }
        }
    }
}

