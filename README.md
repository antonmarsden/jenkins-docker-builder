# jenkins-docker-builder

A jenkins build that uses the host's docker service to perform builds within Jenkins executors. Basically, **docker** (and now **hadolint** to enable Dockerfile testing) are installed on top of the base Jenkins image, and the necessary plugins to run docker within builds are installed.

Note that the volume mapping below (*-v /var/run/docker.sock:/var/run/docker.sock*) is essential, and means that the Jenkins docker binary will use the docker host's docker service.

## Example usage:

```
docker run --name jenkins -p 8080:8080
        -v jenkins_home:/var/jenkins_home
        -v /var/run/docker.sock:/var/run/docker.sock
        -d jenkins-docker-builder
```
