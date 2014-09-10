#!/bin/bash

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

cd ~/bin; ln -s /code/done/done.thor; ln -s /code/docker_rails_app/docker_rails_app.sh
