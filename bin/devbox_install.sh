#!/bin/bash

set -x

sudo apt update
sudo apt upgrade -y
sudo apt dist-upgrade -y

sudo apt install -y \
  apt-transport-https \
  ca-certificates \
  universal-ctags \
  curl \
  dnsutils \
  git \
  gnupg2 \
  libterm-readkey-perl \
  rcm \
  software-properties-common \
  wget

# Install private SSH key
mkdir ~/.ssh
vim ~/.ssh/id_rsa
chmod 400 ~/.ssh/id_rsa

git clone git@github.com:eremite/dotfiles.git
cd; RCRC=$HOME/dotfiles/rcrc rcup -f

vim -c 'PlugInstall'

# Install Docker (https://docs.docker.com/install/linux/docker-ce/debian/)
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker "$USER"
sudo reboot

# Navigate to project_notes in the Files app and "Share with Linux"
PROJECT=project
cd
git clone "git@github.com:$OWNER/$PROJECT.git"
cp "/mnt/chromeos/GoogleDrive/MyDrive/project_notes/$PROJECT.md" "$HOME/$PROJECT/notes.md"
cp "/mnt/chromeos/GoogleDrive/MyDrive/project_notes/$PROJECT.rb" "$HOME/$PROJECT/notes.rb"
cp "/mnt/chromeos/GoogleDrive/MyDrive/project_notes/$PROJECT.yml" "$HOME/$PROJECT/docker-compose.yml"

# Configure AWS (Copy/paste credentials or use `aws configure`)
mkdir ~/.aws
vim ~/.aws/credentials
