#!/usr/bin/env bash
set -x

echo "Updating OS packages"
sudo yum -y update

echo "Update heroku"
heroku update

echo "Update vim plugins"
cd "$HOME/.vim/plugged/vim-rails"
git stash
$DATA/neovim/bin/nvim -c 'PlugUpgrade|PlugUpdate'
git stash pop
cd
