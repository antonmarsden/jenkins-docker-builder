FROM jenkins/jenkins:lts
MAINTAINER anton.marsden@ninetyten.co.nz
USER root

# Install the latest Docker CE binaries
RUN ["/bin/bash", "-c", "apt-get update && \
    apt-get -y install apt-transport-https \
      ca-certificates \
      curl \
      gnupg2 \
      software-properties-common && \
    set -o pipefail && curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo \"$ID\")/gpg | apt-key add - && \
    add-apt-repository \
      \"deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo \"$ID\") \
      $(lsb_release -cs) \
      stable\" && \
   apt-get update && \
   apt-get -y install docker-ce" ]

# Install the necessary plugins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

# drop back from root
USER jenkins

