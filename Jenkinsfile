pipeline {
  agent any
  stages {
    stage('Pull repository') {
      steps {
        git(url: 'https://github.com/antonmarsden/jenkins-docker-builder.git', poll: true)
      }
    }
    stage('Hadolint check') {
      steps {
        sh 'hadolint Dockerfile'
      }
    }
    stage('Build image') {
      steps {
        script {
          docker.build("antonmarsden/jenkins-docker-builder", "--pull .")
        }
        
      }
    }
  }
}