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
RUN echo deb https://get.docker.com/ubuntu docker main > /etc/apt/sources.list.d/docker.list; apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9; DEBIAN_FRONTEND=noninteractive apt-get update -y; DEBIAN_FRONTEND=noninteractive apt-get install -y lxc-docker-1.3.3
RUN cd /tmp; wget https://thoughtbot.github.io/rcm/debs/rcm_1.2.3-1_all.deb; dpkg -i rcm_1.2.3-1_all.deb
RUN wget -qO- https://toolbelt.heroku.com/install.sh | sh
RUN curl -L https://github.com/docker/compose/releases/download/1.2.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose; chmod +x /usr/local/bin/docker-compose
RUN wget https://github.com/github/git-lfs/releases/download/v0.5.1/git-lfs-linux-386-0.5.1.tar.gz; tar -zxf git-lfs-linux-386-0.5.1.tar.gz; sudo cp git-lfs-0.5.1/git-lfs /usr/local/bin
RUN DEBIAN_FRONTEND=noninteractive apt-get clean; rm /tmp/*
RUN echo "%sudo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

RUN useradd --create-home --groups sudo,docker -p $(openssl passwd -1 dev) dev
RUN chsh -s /bin/bash dev
USER dev
ENV USER dev
ENV HOME /home/dev
WORKDIR /home/dev

ADD devbox_init.sh /home/dev/init.sh
