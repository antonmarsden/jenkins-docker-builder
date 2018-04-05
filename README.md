# jenkins-docker-builder

A jenkins build that uses the host's docker service to perform builds within Jenkins executors. The following software is installed on top of the base Jenkins image:
* docker
* hadolint (for Dockerfile linting)
* container-structure-test (for Docker image testing)
* Docker plugins for Jenkins

Note that the volume mapping below (*-v /var/run/docker.sock:/var/run/docker.sock*) is essential, and means that the Jenkins docker binary will use the docker host's docker service.

## Example usage:

```
docker run --name jenkins -p 8080:8080
        -v jenkins_home:/var/jenkins_home
        -v /var/run/docker.sock:/var/run/docker.sock
        -d antonmarsden/jenkins-docker-builder
```
