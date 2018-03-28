# jenkins-docker-builder

Uses the host's docker service to perform builds within Jenkins executors.

## Example usage:

docker run --restart always --name jenkins -p 8080:8080 \
        -v jenkins_home:/var/jenkins_home \
        -v /var/run/docker.sock:/var/run/docker.sock \
        -v /etc/timezone:/etc/timezone -v /etc/localtime:/etc/localtime \
        -d jenkins-docker-builder
