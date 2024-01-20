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

# Install Chrome Extensions
# LastPass: https://chrome.google.com/webstore/detail/lastpass-free-password-ma/hdokiejnpimakedhajhdlcegeplioahd?hl=en
# Vimium: https://chrome.google.com/webstore/detail/vimium/dbepggeogbaibhgnhhndojpepiihcmeb?hl=en

# Install private SSH key
mkdir ~/.ssh
vim ~/.ssh/id_rsa
chmod 400 ~/.ssh/id_rsa

sudo apt install rcm # Install rcup: https://github.com/thoughtbot/rcm

git clone git@github.com:eremite/dotfiles.git
cd; RCRC=$HOME/dotfiles/rcrc rcup -f

vim -c 'PlugInstall'

# Install Docker (https://docs.docker.com/install/linux/docker-ce/debian/)
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker "$USER"
sudo reboot

# Install Docker Compose (https://docs.docker.com/compose/cli-command/#install-on-linux)
mkdir -p ~/.docker/cli-plugins/
curl -SL https://github.com/docker/compose/releases/download/v2.9.0/docker-compose-linux-x86_64 -o ~/.docker/cli-plugins/docker-compose
chmod +x ~/.docker/cli-plugins/docker-compose

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
