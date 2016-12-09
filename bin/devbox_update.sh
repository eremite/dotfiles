#!/usr/bin/env bash
set -x
sudo yum -y update
heroku update
cd "$HOME/.vim/plugged/vim-rails"
git stash
$DATA/neovim/bin/nvim -c 'PlugUpgrade|PlugUpdate'
git stash pop
cd
