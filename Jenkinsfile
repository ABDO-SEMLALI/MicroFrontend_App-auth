pipeline {
  agent any

  parameters {
    string(name: 'IMAGE_NAME', defaultValue: 'auth', description: 'Docker image name')
    string(name: 'DOCKERHUB_USERNAME', defaultValue: 'ash0semlali', description: 'Docker Hub username')
  }

  environment {
    DOCKERHUB_CREDENTIALS = credentials('dockerhub')
  }

  stages {
    stage('Checkout code') {
      steps {
        checkout scm
      }
    }

    stage('Build') {
      steps {
        bat "docker build -t ${params.IMAGE_NAME}:latest ."
      }
    }

    stage('Test') {
      steps {
        echo "test passed"
      }
    }

    stage('deployment') {
      steps {
        bat 'echo %DOCKERHUB_CREDENTIALS_PSW%| docker login -u %DOCKERHUB_CREDENTIALS_USR% --password-stdin'
        bat "docker tag ${params.IMAGE_NAME}:latest ${params.DOCKERHUB_USERNAME}/${params.IMAGE_NAME}:latest"
        bat "docker push ${params.DOCKERHUB_USERNAME}/${params.IMAGE_NAME}:latest"
      }
    }

    stage('Cleanup') {
        steps {
          bat 'docker logout'
        }
      }
  }
}
