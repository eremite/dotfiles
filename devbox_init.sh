#!/bin/bash

DATA='/data'

# So I can docker without sudo
sudo chmod o+rw /var/run/docker.sock

# Install dotfiles
if [ ! -d "$DATA/dotfiles" ]; then
  git clone https://github.com/eremite/dotfiles.git $DATA/dotfiles
fi
cd; ln -s $DATA/dotfiles/rcrc .rcrc; rcup

# Set up ssh
mkdir -p ~/.ssh; cd ~/.ssh; ~/.git_template/hooks/create_symlinks
eval `ssh-agent -s`
ssh-add id_rsa

# Set up and trigger hooks on checkout
cd $DATA/dotfiles; git init; git checkout master

# Patch app_rake_command in vim-rails to support running rake with fig.
cd /home/dev/.vim/plugged/vim-rails; patch -p1 < $DATA/meta/dotfiles/rails_app_rake_command.patch

# Start tmux
cd $DATA
tmux
