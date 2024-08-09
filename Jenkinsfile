pipeline {
    agent any

    environment {
        DOCKER_IMAGE_NAME = 'teste-docker-jenkins'
        DOCKER_TAG = 'latest'
    }

    stages {
        stage('Checkout') {
            steps {

            }
        }

        stage('Build') {
            steps {
                script {
                    // Construir o projeto Spring Boot usando Gradle
                    sh 'gradle  build'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Construir a imagem Docker
                    docker.build("${DOCKER_IMAGE_NAME}:${DOCKER_TAG}")
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Rodar o container Docker
                    docker.image("${DOCKER_IMAGE_NAME}:${DOCKER_TAG}").run('-p 8088:8088')
                }
            }
        }
    }

    post {
        always {
            // Limpar containers e imagens Docker não utilizados após o build
            sh 'docker system prune -af || true'
        }
    }
}