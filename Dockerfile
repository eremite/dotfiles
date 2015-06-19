FROM ubuntu:14.04
MAINTAINER Daniel Esplin <daniel@custombit.com>

RUN DEBIAN_FRONTEND=noninteractive locale-gen en_US en_US.UTF-8; DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN DEBIAN_FRONTEND=noninteractive apt-get update -y; DEBIAN_FRONTEND=noninteractive apt-get upgrade -y -q
RUN mkdir -p /tmp/scripts
COPY dockerfile_scripts /tmp/scripts
RUN /tmp/scripts/install_packages.sh
RUN /tmp/scripts/install_docker.sh
RUN /tmp/scripts/install_docker_compose.sh
RUN /tmp/scripts/install_git_lfs.sh
RUN /tmp/scripts/install_heroku.sh
RUN /tmp/scripts/install_rcm.sh
RUN /tmp/scripts/install_github_hub.sh
RUN rm -rf /tmps/scripts
RUN DEBIAN_FRONTEND=noninteractive apt-get clean
RUN echo "%sudo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

RUN useradd --create-home --groups sudo,docker -p $(openssl passwd -1 dev) dev
RUN chsh -s /bin/bash dev
USER dev
ENV USER dev
ENV HOME /home/dev
WORKDIR /home/dev

COPY devbox_init.sh /home/dev/init.sh
