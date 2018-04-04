// Basic Jenkinsfile to demonstrate features of jenkins-docker-builder
node {
    
    stage('Get docker project') {
        git 'https://github.com/antonmarsden/jenkins-docker-builder.git'
    }

    def app

    stage('Check with hadolint') {
        // check the Dockerfile with hadolint prior to a build
        sh 'hadolint Dockerfile'
    }

    stage('Build image') {
        /* This builds the actual image; synonymous to
         * docker build on the command line */
        app = docker.build("antonmarsden/jenkins-docker-builder", "--pull .")
    }

}

