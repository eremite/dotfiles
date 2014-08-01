#!/bin/bash

# Docker bug?
sudo chsh -s /bin/bash dev

# Authentication permissions
mkdir -p ~/.ssh
cp /personal/id_rsa* ~/.ssh
cp /personal/.netrc ~

# Trigger checkout callbacks
cd ~/dotfiles; git checkout master
cd ~/done; git checkout master
cd ~/docker_rails_app; git checkout master
