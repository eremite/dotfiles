#!/bin/bash

set -x

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

# Install SSH key
nvim ~/.ssh/id_rsa

# Install rcup: https://github.com/thoughtbot/rcm
git clone git://github.com:eremite/dotfiles.git
cd; RCRC=/home/eremite/dotfiles/rcrc rcup -f

# https://docs.docker.com/install/linux/docker-ce/debian/
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER
reboot

# https://docs.docker.com/compose/install/

# https://ngrok.com/download

# ctrl-shift-p Restore Shell defaults

# $HOME/neovim/bin/nvim -c 'PlugInstall'
