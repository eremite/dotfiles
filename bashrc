# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth
# increase size of history
export HISTSIZE=1000000
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color)
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    ;;
*)
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    ;;
esac

# Comment in the above and uncomment this below for a color prompt
#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# If this is an xterm set the title to dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;$(basename `pwd`)\007"'
    ;;
*)
    ;;
esac

# add bin to the path
export PATH=$PATH:$HOME/bin

if [ "$TERM" != "dumb" ]; then
  eval "`dircolors -b`"
  alias ls='ls --color=auto'
fi

# enable programmable completion features
if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

# Shows the current git branch in your shell prompt
function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
}
export PS1='\u@\h:$(parse_git_branch)\w$ '

# Load a rails database
function dbload {
  if [ $1 ]; then
    scp $1:/home/daniel/db.sql .
  fi
  database=`grep -m 1 database config/database.yml | cut -d ":" -f 2`
  database=${database//[[:space:]]}
  mysql -uroot ${database} < db.sql
}

# Open tomboy note from menu
function tb {
  DMENU_ARGS="-i -fn -*-terminal-*-*-*-*-18-*-*-*-*-*-*-*" # xfontsel to select font
  tomboy --open-note $(grep -ho '<title>\(.*\)</title>' $HOME/.local/share/tomboy/* | sed 's#</\?title>##g' | dmenu $DMENU_ARGS)
}

# Get a new project from git and symlink it to $HOME
function get {
  project=${1/.git/}
  git clone ssh://git.mokisystems.com/var/repos/${project}.git /media/sdb1/${project}
  cd
  ln -s /media/sdb1/${project}
  cd ${project}
  if [ -e "config/database.yml.example" ]; then
    cp config/database.yml{.example,}
  fi
}

# Run autotest or autospec
function t {
  if [ -e "spec" ]; then
    autospec
  fi
  if [ -e "test" ]; then
    autotest
  else
    echo "Aborting. No tests found."
  fi
}

# Timeclock the last git commit message
function jg {
  log=`git log -n1 --pretty=format:%s --no-merges`
  echo $log
  j $1 $log
}

# ls
alias ll='ls -lh'
alias la='ls -A'
alias l='ls -1'

# cd
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias s='cd /etc/apache2/sites-available/'

# svn
alias sd='svn diff'
alias svnd='svn diff -r PREV'
alias svnr='svn resolved'

# git
alias gl='git pull --rebase'
alias gp='git push'
alias gd='git diff'
alias gD='git diff --cached'
alias ga='git add'
alias gc='git commit -v'
alias gb='git branch'
alias gs='git status'
alias gr='git rebase'
alias gri='git rebase -i origin/master'
alias grc='git rebase --continue'
alias grh='git reset HEAD'
alias gca='git commit --amend'
alias gm='git merge'
alias gw='git whatchanged'
alias gg='git log'
alias gco='git checkout'
alias grm="git status | grep deleted | awk '{print \$3}' | xargs git rm"
alias gps='git svn dcommit'
alias gls='git svn rebase'

# enable tab completion
complete -o default -o nospace -F _git_checkout gm
complete -o default -o nospace -F _git_checkout gb
complete -o default -o nospace -F _git_checkout gco

# rails
complete -C $HOME/.rake/tab_completion -o default rake
alias rr='rake routes | grep'
alias mig='rake db:migrate db:test:clone'
alias rs='touch tmp/restart.txt'
alias ss='ruby script/server'
alias sc='ruby script/console'

# logs
alias tld='tail -fn100 log/development.log'
alias tlt='tail -fn100 log/test.log'
alias tlp='tail -fn100 log/production.log'
alias tldg="tail -fn100 log/development.log | grep '###'"
alias tltg="tail -fn100 log/test.log | grep '###'"
alias lsd='less log/development.log'
alias lst='less log/test.log'
alias lsp='less log/production.log'

# apache
alias vhosts='sudo vim /etc/hosts'
alias rsa='sudo /usr/sbin/apache2ctl graceful'

# vim
alias v='vim'

# bash
alias x='exit'
alias nh='telnet nethack.alt.org'

# Map Caps Lock to ESC
xmodmap -e "clear lock"
xmodmap -e "keycode 0x42 = Escape"

