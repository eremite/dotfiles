# ls
alias ll='ls -alh'
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

# rails
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
