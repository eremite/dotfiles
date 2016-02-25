FROM ubuntu:14.04
MAINTAINER Daniel Esplin <daniel@custombit.com>

RUN DEBIAN_FRONTEND=noninteractive locale-gen en_US en_US.UTF-8; DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

COPY dockerfile_scripts dockerfile_scripts
RUN dockerfile_scripts/install_packages.sh
#RUN dockerfile_scripts/install_docker.sh
#RUN dockerfile_scripts/install_docker_compose.sh

ENV DIND_COMMIT=b8bed8832b77a478360ae946a69dab5e922b194e DOCKER_VERSION=1.9.1 COMPOSE_VERSION=1.5.2
ADD https://get.docker.com/builds/Linux/x86_64/docker-${DOCKER_VERSION} /usr/bin/docker
ADD https://raw.githubusercontent.com/docker/docker/${DIND_COMMIT}/hack/dind /usr/local/bin/dind
ADD https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-linux-x86_64 /usr/local/bin/docker-compose
RUN chmod +x /usr/bin/docker /usr/local/bin/dind /usr/local/bin/docker-compose && rm -fr /var/lib/docker/*

RUN dockerfile_scripts/install_git_lfs.sh
RUN dockerfile_scripts/install_heroku.sh
RUN dockerfile_scripts/install_rcm.sh
RUN dockerfile_scripts/install_github_hub.sh
RUN rm -rf dockerfile_scripts
RUN DEBIAN_FRONTEND=noninteractive apt-get clean
RUN echo "%sudo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

RUN useradd --create-home --groups sudo -p $(openssl passwd -1 dev) dev
RUN chsh -s /bin/bash dev
USER dev
ENV USER dev
ENV HOME /home/dev
WORKDIR /home/dev

COPY devbox_init.sh /home/dev/init.sh
