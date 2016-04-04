#!/usr/bin/env bash
set -x
sudo yum -y update
heroku update
cd "$HOME/.vim/plugged/vim-rails"
git stash
vim -c 'PlugUpdate'
git stash pop
cd
