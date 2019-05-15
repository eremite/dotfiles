#!/usr/bin/env bash
set -x

echo "Updating OS packages"
sudo apt-get update
sudo apt-get upgrade -y

echo "Update vim plugins"
cd "$HOME/.vim/plugged/vim-rails"
git stash
vim -c 'PlugUpgrade|PlugUpdate'
git stash pop
cd
