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
          docker.build(DOCKER_IMAGE_TARGET, "--pull .")
        }

      }
    }
    stage('Test image') {
      steps {
        sh '/bin/container-structure-test test --image $DOCKER_IMAGE_TARGET --config tests/*.yaml'
      }
    }
  }
  environment {
    DOCKER_IMAGE_TARGET = 'antonmarsden/docker-image-builder'
  }
}