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
                dir("${WORK_DIR}") {
                    git branch: 'main', url: 'https://github.com/SukeshKaicharla/netflix-clone-react-typescript.git'
                }
            }
        }

        stage('Install Dependencies & Build') {
            steps {
                dir("${WORK_DIR}") {
                    sh '''
                        npm install
                        npm run build
                    '''
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                dir("${WORK_DIR}") {
                    sh '''
                        docker rmi -f ${IMAGE_NAME}:${IMAGE_TAG} || true
                        docker build -t ${IMAGE_NAME}:${IMAGE_TAG} -f ${WORK_DIR}/Dockerfile ${WORK_DIR}
                    '''
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                dir("${WORK_DIR}") {
                    sh '''
                        docker rm -f ${CONTAINER_NAME} || true
                        docker run -d --name ${CONTAINER_NAME} -p 3000:8080 ${IMAGE_NAME}:${IMAGE_TAG}
                    '''
                }
            }
        }
    }
}
