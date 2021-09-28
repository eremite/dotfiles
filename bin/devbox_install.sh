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

vim -c 'PlugInstall'

# Install Docker (https://docs.docker.com/install/linux/docker-ce/debian/)
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker "$USER"
sudo reboot

# https://docs.docker.com/compose/install/
DOCKER_COMPOSE_VERSION=v2.0.0
curl -SL "https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-linux-amd64" -o "$HOME/.docker/cli-plugins/docker-compose"
chmod +x !$

# Navigate to project_notes in the Files app and "Share with Linux"
PROJECT=project
cd
git clone "git@github.com:$OWNER/$PROJECT.git"
cp "/mnt/chromeos/GoogleDrive/MyDrive/project_notes/$PROJECT.md" "$HOME/$PROJECT/notes.md"
cp "/mnt/chromeos/GoogleDrive/MyDrive/project_notes/$PROJECT.rb" "$HOME/$PROJECT/notes.rb"
cp "/mnt/chromeos/GoogleDrive/MyDrive/project_notes/$PROJECT.yml" "$HOME/$PROJECT/docker-compose.yml"

aws configure
