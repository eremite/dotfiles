#!/bin/bash

# So I can docker without sudo
sudo chmod o+rw /var/run/docker.sock

# Install dotfiles
if [ ! -d "$DATA/dotfiles" ]; then
  git clone https://github.com/eremite/dotfiles.git $DATA/dotfiles
fi
cd; ln -s $DATA/dotfiles/rcrc .rcrc; rcup

# Set up ssh config
cd ~/.ssh; ~/.git_template/hooks/create_symlinks

# Trigger checkout callbacks
cd $DATA/dotfiles; git init; git checkout master

# Start tmux
cd $DATA
tmux
