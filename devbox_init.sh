#!/bin/bash

# So I can docker without sudo
sudo chmod o+rw /var/run/docker.sock

# Update and trigger checkout callbacks
cd ~/dotfiles; git init; git checkout master; git pull

# Set up ssh config
cd ~/.ssh; ~/.git_template/hooks/create_symlinks

cd $DATA
tmux
