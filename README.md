# jenkins-docker-builder

A jenkins build that uses the host's docker service to perform builds within Jenkins executors. Basically, docker (and now hadolint) are installed on top of the base Jenkins image, and the necessary plugins to run docker within builds are installed.

## Example usage:

```
docker run --name jenkins -p 8080:8080
        -v jenkins_home:/var/jenkins_home
        -v /var/run/docker.sock:/var/run/docker.sock
        -d jenkins-docker-builder
```
