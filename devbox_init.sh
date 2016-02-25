#!/bin/bash

DATA='/data'

sudo docker daemon --host=unix:///var/run/docker.sock --host=tcp://0.0.0.0:2375 --storage-driver=vfs &

# So I can create files in the /data directory
sudo chown -R dev:dev /data

# Install dotfiles
if [ ! -d "$DATA/dotfiles" ]; then
  git clone https://github.com/eremite/dotfiles.git $DATA/dotfiles
fi
if [ -d "$DATA/meta/secure" ]; then
  cp $DATA/meta/secure/netrc $DATA/dotfiles
  cp $DATA/meta/secure/dockercfg $DATA/dotfiles
  cp $DATA/meta/secure/id_rsa* $DATA/dotfiles/ssh
fi
cd; RCRC=$DATA/dotfiles/rcrc rcup
mkdir -p ~/.config; ln -sf $DATA/meta/secure/hub ~/.config/hub
rm $DATA/dotfiles/netrc $DATA/dotfiles/dockercfg $DATA/dotfiles/ssh/id_rsa*
if [ -d "$DATA/meta/dotfiles/plugged" ]; then
  mkdir -p $HOME/.vim
  cd $HOME/.vim
  ln -s $DATA/meta/dotfiles/plugged
  cd -
fi

# So I can docker without sudo
sudo chmod o+rw /var/run/docker.sock
sudo chmod a+rx /usr/local/bin/docker-compose

# Symlink everyhing in $DATA to home
cd; ln -s $DATA/* ~

# Start tmux
tmux
