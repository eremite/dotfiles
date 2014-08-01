FROM ubuntu:14.04
MAINTAINER Daniel Esplin <daniel@custombit.com>

RUN DEBIAN_FRONTEND=noninteractive locale-gen en_US en_US.UTF-8; DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN DEBIAN_FRONTEND=noninteractive apt-get update -y; DEBIAN_FRONTEND=noninteractive apt-get upgrade -y -q
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install vim-nox git-core tmux build-essential
# libterm-readkey-perl is for git singlekey interactive
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install libterm-readkey-perl exuberant-ctags wget curl
RUN cd /tmp; curl -s https://get.docker.io/ubuntu/ | sh
RUN cd /tmp; wget https://thoughtbot.github.io/rcm/debs/rcm_1.2.3-1_all.deb; dpkg -i rcm_1.2.3-1_all.deb
RUN wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh
RUN DEBIAN_FRONTEND=noninteractive apt-get clean; rm /tmp/*
RUN gem install bundler;
RUN echo "%sudo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

RUN useradd --create-home --groups sudo,docker -p $(openssl passwd -1 dev) dev
# RUN chsh -s /bin/bash dev # Fails with "PAM: System error" on Docker Hub. Docker bug?
USER dev
ENV USER dev
ENV HOME /home/dev
WORKDIR /home/dev
RUN mkdir bin

RUN git clone https://github.com/eremite/dotfiles
RUN ln -s dotfiles/rcrc .rcrc; rcup
RUN curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh
RUN /home/dev/.vim/bundle/neobundle.vim/bin/neoinstall

RUN git clone https://github.com/eremite/done; cd done; bundle install --path vendor/bundle; ln -s /vagrant/gitignores/done/config.yml; cd /home/dev/bin; ln -s /home/dev/done/done.thor
RUN git clone https://github.com/eremite/docker_rails_app

RUN printf "sudo chsh -s /bin/bash dev\nmkdir -p ~/.ssh\ncp /personal/id_rsa* ~/.ssh\ncp /personal/.netrc ~" > init.sh; chmod +x init.sh

# boot2docker init --memory=4096 --disksize=80000
# docker pull eremite/devbox
# docker build --force-rm -t eremite/devbox .
# docker run -v /code --name code busybox true
# docker run -v /personal --name personal busybox true
# docker run --rm -v /usr/local/bin/docker:/docker -v /var/run/docker.sock:/docker.sock svendowideit/samba personal
# sudo mkdir -p /Volumes/personal; sudo mount_smbfs //guest@192.168.59.104/personal /Volumes/personal
# docker run -it --rm --volumes-from code --volumes-from personal -v /var/run/docker.sock:/var/run/docker.sock eremite/devbox /bin/bash --login
#   sudo chown dev:dev /code; sudo chown dev:dev /personal
# docker run --volumes-from personal -v $(pwd):/backup busybox tar -C /personal --exclude='**/tmp' -c -f - . | gzip > /backup/personal.tar.gz
