#!/bin/bash

# So I can docker without sudo
sudo chmod o+rw /var/run/docker.sock

# Install dotfiles
if [ ! -d "$DATA/dotfiles" ]; then
  git clone git@github.com:eremite/dotfiles.git $DATA/dotfiles
fi
cd; ln -s /$DATA/dotfiles/rcrc .rcrc; rcup

# Set up ssh config
cd ~/.ssh; ~/.git_template/hooks/create_symlinks

cd $DATA
tmux
