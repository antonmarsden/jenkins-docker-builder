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
        sh 'git ls-files --exclude=\'Dockerfile*\' --ignored |xargs --max-lines=1 hadolint'
      }
    }
    stage('Build image') {
      steps {
        script {
          docker.build("antonmarsden/jenkins-docker-builder", "--pull .")
        }
        
      }
    }
    stage('Test image') {
      steps {
        sh 'container-structure-test test --image antonmarsden/jenkins-docker-builder --config tests/*.yaml'
      }
    }
  }
}
