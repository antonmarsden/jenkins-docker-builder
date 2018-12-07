# hadolint ignore=DL3006
FROM hadolint/hadolint as hadolint

FROM jenkins/jenkins:lts
LABEL maintainer="anton.marsden@ninetyten.co.nz"
# hadolint ignore=DL3002
USER root

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
# Install the latest Docker CE binaries
# hadolint ignore=SC1091,DL3008
RUN [ "apt-get update && \
    apt-get --no-install-recommends -y install apt-transport-https \
      ca-certificates \
      curl \
      gnupg2 \
      software-properties-common && \
    curl -fsSL \"https://download.docker.com/linux/$(. /etc/os-release; echo \"$ID\")/gpg\" | apt-key add - && \
    add-apt-repository \
      \"deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo \"$ID\") \
      $(lsb_release -cs) \
      stable\" && \
   apt-get update && \
   apt-get --no-install-recommends -y install docker-ce && \
   apt-get clean && \
   rm -rf /var/lib/apt/lists/* && \
   adduser jenkins docker" ]

# Install the necessary plugins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

# Install hadolint
COPY --from=hadolint /bin/hadolint /bin

# Install container-structure-test
ARG CONTAINER_STRUCTURE_TEST_VERSION=v1.6.0

RUN curl -sSLO https://storage.googleapis.com/container-structure-test/$CONTAINER_STRUCTURE_TEST_VERSION/container-structure-test-linux-amd64 && chmod +x container-structure-test-linux-amd64 && mv container-structure-test-linux-amd64 /bin/container-structure-test

# drop back from root
USER jenkins
