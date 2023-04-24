#!/usr/bin/env bash
set -x

echo "Updating OS packages"
sudo apt-get update
sudo apt-get upgrade -y
sudo apt full-upgrade -y

echo "Update vim plugins"
vim -c 'PlugUpgrade|PlugUpdate'
