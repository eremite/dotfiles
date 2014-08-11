#!/bin/bash

# Docker bug?
sudo chsh -s /bin/bash dev

# Authentication permissions
cp /personal/id_rsa* ~/.ssh
cp /personal/.netrc ~

# Update and trigger checkout callbacks
cd ~/dotfiles; git init; git checkout master; git pull
cd ~/done; git checkout master; git pull
cd ~/docker_rails_app; git checkout master; git pull
