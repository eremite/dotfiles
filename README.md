## Installation

    git clone https://github.com/eremite/dotfiles ~/gits/dotfiles
    cd !$
    git submodule init
    git submodule update
    cd
    ln -s {~/gits/dotfiles/,.}bashrc
    ln -s {~/gits/dotfiles/,.}bash_aliases
    ln -s {~/gits/dotfiles/,.}bashrc
    ln -s {~/gits/dotfiles/,.}ccsm.profile
    ln -s {~/gits/dotfiles/,.}gitignore
    ln -s {~/gits/dotfiles/,.}inputrc
    ln -s {~/gits/dotfiles/,.}irbrc
    ln -s {~/gits/dotfiles/,.}profile
    ln -s {~/gits/dotfiles/,.}railsrc
    ln -s {~/gits/dotfiles/,.}server
    ln -s {~/gits/dotfiles/,.}vim
    ln -s {~/gits/dotfiles/,.}vimrc
    ln -s {~/gits/dotfiles/,.}xbindkeysrc

## Server dotfiles

The files in the server directory are stripped down dotfiles for remote servers.

Rather than using git to sync them (too much hassle) I just scp them over from
my local machine (with a script in my [binfiles repo][http://github.com/eremite/binfiles]).
