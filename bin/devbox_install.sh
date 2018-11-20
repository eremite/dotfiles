#!/bin/bash

set -x

export DATA="$HOME"

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y

sudo apt-get install -y \
  apt-transport-https \
  ca-certificates \
  curl \
  git \
  gnupg2 \
  libterm-readkey-perl \
  neovim \
  software-properties-common \
  tmux \
  wget

curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) \
  stable"

sudo apt-get update
sudo apt-get install -y docker-ce
sudo usermod -aG docker

sudo curl -L "https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

VERSION=2.6.0
wget https://github.com/github/hub/releases/download/v$VERSION/hub-linux-amd64-$VERSION.tgz
tar -zxf hub-linux-amd64-$VERSION.tgz
sudo cp hub-linux-amd64-$VERSION/bin/hub /usr/local/bin
rm -r hub*

wget -qO - https://apt.thoughtbot.com/thoughtbot.gpg.key | sudo apt-key add -
echo "deb https://apt.thoughtbot.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/thoughtbot.list
sudo apt-get update
sudo apt-get install rcm

git clone https://github.com/eremite/dotfiles.git $DATA/dotfiles
cd; RCRC=/home/eremite/dotfiles/rcrc rcup -f
