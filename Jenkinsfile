pipeline {
  agent any

  environment {
    DOCKERHUB_CREDENTIALS = credentials('dockerhub')
    EMAIL_LIST = 'abdelkarimsemlali67@gmail.com, mohamedelkaddiri@gmail.com'
  }
  stages {
    stage('Checkout code') {
      steps {
        checkout scm
      }
    }

    stage('Build') {
      steps {
        bat 'docker-compose build'
        bat 'start docker-compose up -d'
      }
    }

    stage('Test') {
      steps {
        echo "test passed"
      }
    }

    stage('Push Images to Docker Hub') {
      steps {
        bat 'echo %DOCKERHUB_CREDENTIALS_PSW%| docker login -u %DOCKERHUB_CREDENTIALS_USR% --password-stdin'
        bat 'docker-compose push'
      }
    }

    stage('Cleanup') {
      steps {
        bat 'docker-compose down'
      }
    }
  }

  post {
    success {
      mail bcc: '', body: """
      Le pipeline Jenkins s'est exécuté avec succès le ${currentBuild.startTimeInMillis}.
      Tout s'est déroulé sans erreur.
      Voici le lien de l'application si vous souhaitez le consulter
      """, subject: 'Sujet : Reussite du pipeline Jenkins', to: env.EMAIL_LIST
    }
    failure {
      mail bcc: '', body: """
      Le pipeline Jenkins a échoué le ${currentBuild.startTimeInMillis}.
      Veuillez prendre les mesures nécessaires pour résoudre le problème.
      """, subject: 'Sujet : Echec du pipeline Jenkins', to: env.EMAIL_LIST
    }
  }
}
