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
# NEED TO WAIT FOR LATEST DOCKER >= 17.05
#COPY --from=hadolint/hadolint:latest /bin/hadolint /bin

# drop back from root
USER jenkins

