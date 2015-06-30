#!/bin/bash

DATA='/data'

# So I can docker without sudo
sudo chmod o+rw /var/run/docker.sock

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

# Start tmux
cd $DATA
tmux
