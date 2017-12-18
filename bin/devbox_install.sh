#!/bin/bash

set -x

sudo yum update -y

# Set up data directory

export DATA="$HOME/data"
mkdir -p $DATA

# Development Tools

sudo yum groupinstall -y "Development Tools" "Development Libraries"
sudo yum install -y yum-utils

vim --version | grep vim
[ "$?" -ne 0 ] && echo "ERROR: no vim" && exit 1

git version | grep git
[ "$?" -ne 0 ] && echo "ERROR: no git" && exit 1

echo -n "checking wget..."
wget --version | grep wget
[ "$?" -ne 0 ] && echo "ERROR: no wget" && exit 1

echo -n "checking curl..."
curl --version | grep curl
[ "$?" -ne 0 ] && echo "ERROR: no curl" && exit 1

# neovim
sudo yum -y install libtool autoconf automake cmake gcc gcc-c++ make pkgconfig unzip
cd $DATA
git clone git@github.com:neovim/neovim.git
cd neovim
git checkout v0.1.7
make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$DATA/neovim"
make install
bin/nvim --version | grep NVIM
[ "$?" -ne 0 ] && echo "ERROR: no neovim" && exit 1

# Docker
cd $DATA
wget https://get.docker.com/builds/Linux/x86_64/docker-latest.tgz
sudo tar zxf docker-latest.tgz
# sudo mv docker/* /usr/bin/
# rmdir docker
echo "Requires manual install:"
echo "sudo vim /etc/sysconfig/docker # add '--storage-driver overlay2' to OPTIONS"
exit 1
sudo service docker start
sudo usermod -aG docker $(whoami)
echo -n "checking docker..."
docker --version | grep Docker
[ "$?" -ne 0 ] && echo "ERROR: no docker" && exit 1

# Docker Compose

VERSION=1.11.1
curl -L https://github.com/docker/compose/releases/download/$VERSION/docker-compose-`uname -s`-`uname -m` > docker-compose
chmod +x docker-compose
sudo mv docker-compose /usr/local/bin/docker-compose
docker-compose --version | grep $VERSION
[ "$?" -ne 0 ] && echo "ERROR: no docker-compose" && exit 1

# Tmux

sudo yum install -y tmux

tmux -V | grep tmux
[ "$?" -ne 0 ] && echo "ERROR: no tmux" && exit 1

# Github hub

VERSION=2.2.9
wget https://github.com/github/hub/releases/download/v$VERSION/hub-linux-amd64-$VERSION.tgz
tar -zxf hub-linux-amd64-$VERSION.tgz
sudo cp hub-linux-amd64-$VERSION/bin/hub /usr/local/bin
rm -r hub*

hub version | grep hub
[ "$?" -ne 0 ] && echo "ERROR: no hub" && exit 1

# Git lfs
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.rpm.sh | sudo bash
sudo yum install -y git-lfs
git lfs install

git lfs version | grep lfs
[ "$?" -ne 0 ] && echo "ERROR: no git lfs" && exit 1

# Heroku Toolbelt

wget -qO- https://toolbelt.heroku.com/install.sh | sh
/usr/local/heroku/bin/heroku --version | grep heroku
[ "$?" -ne 0 ] && echo "ERROR: no heroku" && exit 1

# RCM

cd /etc/yum.repos.d/
sudo wget http://download.opensuse.org/repositories/utilities/CentOS_6/utilities.repo
sudo yum install -y rcm

rcup -V | grep rcup
[ "$?" -ne 0 ] && echo "ERROR: no rcup" && exit 1

if [ ! -d "$DATA/dotfiles" ]; then
  git clone https://github.com/eremite/dotfiles.git $DATA/dotfiles
fi
cd; RCRC=$DATA/dotfiles/rcrc rcup -f

echo "Ready to go!"
