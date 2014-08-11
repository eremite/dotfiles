#!/bin/bash

# Docker bug?
sudo chsh -s /bin/bash dev

# So I can docker without sudo
sudo chmod o+rw /var/run/docker.sock

# Fix permissions of attached volumes
sudo chown -R dev:dev /code

# Authentication permissions
cp $PERSONAL/id_rsa* ~/.ssh
cp $PERSONAL/.netrc ~

# Update and trigger checkout callbacks
cd ~/dotfiles; git init; git checkout master; git pull
cd ~/done; git checkout master; git pull
cd ~/docker_rails_app; git checkout master; git pull
