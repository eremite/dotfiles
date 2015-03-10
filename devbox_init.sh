#!/bin/bash

DATA='/data'

# So I can docker without sudo
sudo chmod o+rw /var/run/docker.sock

# Install dotfiles
if [ ! -d "$DATA/dotfiles" ]; then
  git clone https://github.com/eremite/dotfiles.git $DATA/dotfiles
fi
if [ -d "$DATA/meta/secure" ]; then
  cp $DATA/meta/secure/netrc $DATA/dotfiles
  cp $DATA/meta/secure/id_rsa* $DATA/dotfiles/ssh
fi
cd; RCRC=$DATA/dotfiles/rcrc rcup
rm $DATA/dotfiles/netrc $DATA/dotfiles/ssh/id_rsa*
if [ -d "$DATA/meta/dotfiles/plugged" ]; then
  cd $HOME/.vim
  ln -s $DATA/meta/dotfiles/plugged
  cd -
fi
# Patch app_rake_command in vim-rails to support running rake with fig.
cd /home/dev/.vim/plugged/vim-rails; patch -p1 < $DATA/meta/dotfiles/rails_app_rake_command.patch

# Start tmux
cd $DATA
tmux
