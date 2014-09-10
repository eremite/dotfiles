#!/bin/bash

# So I can docker without sudo
sudo chmod o+rw /var/run/docker.sock

# Fix permissions of attached volumes
sudo chown -R dev:dev $DATA

# Authentication permissions
cp $META/id_rsa* ~/.ssh
cp $META/.netrc ~
cd ~/.ssh; rm config; ln -s $META/ssh_config config

# Update and trigger checkout callbacks
cd ~/dotfiles; git init; git checkout master; git pull
cd ~/done; git checkout master; git pull

cd ~/bin; ln -s ~/done/done.thor; ln -s $DATA/docker_rails_app/docker_rails_app.sh
