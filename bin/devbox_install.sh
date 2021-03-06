#!/bin/bash

set -x

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y

sudo apt-get install -y \
  apt-transport-https \
  ca-certificates \
  ctags \
  curl \
  dnsutils \
  git \
  gnupg2 \
  libterm-readkey-perl \
  software-properties-common \
  wget

# Install private SSH key
mkdir ~/.ssh
vim ~/.ssh/id_rsa
chmod 400 ~/.ssh/id_rsa

# Install rcup: https://github.com/thoughtbot/rcm

git clone git@github.com:eremite/dotfiles.git
cd; RCRC=$HOME/dotfiles/rcrc rcup -f

# Install Docker (https://docs.docker.com/install/linux/docker-ce/debian/)
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker "$USER"
reboot
# docker login

# https://docs.docker.com/compose/install/

# https://ngrok.com/download
# wget $FILE
# unzip $FILE
# sudo mv ngrok /usr/local/bin

aws configure

vim -c 'PlugInstall'
