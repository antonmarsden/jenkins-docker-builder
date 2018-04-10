# hadolint ignore=DL3006
FROM hadolint/hadolint as hadolint

FROM jenkins/jenkins:lts
LABEL maintainer="anton.marsden@ninetyten.co.nz"
# hadolint ignore=DL3002
USER root

# Install the latest Docker CE binaries
# hadolint ignore=SC1091
RUN [ "/bin/bash", "-c", "apt-get update && \
    apt-get -y install apt-transport-https \
      ca-certificates \
      curl \
      gnupg2 \
      software-properties-common && \
    set -o pipefail && curl -fsSL \"https://download.docker.com/linux/$(. /etc/os-release; echo \"$ID\")/gpg\" | apt-key add - && \
    add-apt-repository \
      \"deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo \"$ID\") \
      $(lsb_release -cs) \
      stable\" && \
   apt-get update && \
   apt-get -y install docker-ce && \
   adduser jenkins docker" ]

# Install the necessary plugins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

# Install hadolint
COPY --from=hadolint /bin/hadolint /bin

# Install container-structure-test
ARG CONTAINER_STRUCTURE_TEST_VERSION=v1.1.0

RUN curl -sSLO "https://storage.googleapis.com/container-structure-test/$CONTAINER_STRUCTURE_TEST_VERSION/container-structure-test" && chmod +x container-structure-test && mv container-structure-test /bin/

# drop back from root
USER jenkins

