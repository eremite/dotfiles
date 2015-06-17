FROM ubuntu:14.04
MAINTAINER Daniel Esplin <daniel@custombit.com>

RUN DEBIAN_FRONTEND=noninteractive locale-gen en_US en_US.UTF-8; DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN DEBIAN_FRONTEND=noninteractive apt-get update -y; DEBIAN_FRONTEND=noninteractive apt-get upgrade -y -q
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install vim-nox git-core tmux build-essential
# libterm-readkey-perl is for git singlekey interactive
# apt-transport-https for docker
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install libterm-readkey-perl exuberant-ctags wget curl apt-transport-https
COPY dockerfile_scripts dockerfile_scripts
RUN dockerfile_scripts/install_docker.sh
RUN dockerfile_scripts/install_docker_compose.sh
RUN dockerfile_scripts/install_git_lfs.sh
RUN dockerfile_scripts/install_heroku.sh
RUN dockerfile_scripts/install_rcm.sh
RUN rm -rf dockerfile_scripts
RUN DEBIAN_FRONTEND=noninteractive apt-get clean
RUN echo "%sudo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

RUN useradd --create-home --groups sudo,docker -p $(openssl passwd -1 dev) dev
RUN chsh -s /bin/bash dev
USER dev
ENV USER dev
ENV HOME /home/dev
WORKDIR /home/dev

ADD devbox_init.sh /home/dev/init.sh
