## Boostrap new instance

```sh
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
  wget

# Install private SSH key
mkdir ~/.ssh
vim ~/.ssh/id_rsa
chmod 400 ~/.ssh/id_rsa

git clone git@github.com:eremite/dotfiles.git
cd; RCRC=$HOME/dotfiles/rcrc rcup -f
cd $HOME/dotfiles
git config user.email "you@example.com"
git config user.name "eremite"
cd

vim -c 'PlugInstall'

# Install Docker (https://docs.docker.com/install/linux/docker-ce/debian/)
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker "$USER"
sudo reboot

# Configure AWS (Copy/paste credentials or use `aws configure`)
mkdir ~/.aws
vim ~/.aws/credentials
