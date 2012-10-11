# ls
alias ll='ls -alh'
alias la='ls -A'
alias l='ls -1'

# cd
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias s='cd /etc/apache2/sites-enabled'
alias b='cd /media/sdb1'

# svn
alias sd='svn diff'
alias svnd='svn diff -r PREV'
alias svnr='svn resolved'

# git
alias gl='git pull --rebase'
alias gp='git push'
alias gd='git diff --ignore-submodules'
alias gD='git diff --cached'
alias ga='git add'
alias gai='git add --patch' # i for interactive
alias gan='git add --intent-to-add' # n for -N (new files), makes the above gai even better
alias gc='git commit -v'
alias gb='git branch'
complete -o default -o nospace -F _git_checkout gb
alias gs='git status'
alias gr='git rebase'
alias gri='git rebase --interactive --autosquash origin/master'
alias grc='git rebase --continue'
alias grh='git reset HEAD'
alias gca='git commit --amend'
alias gm='git merge'
# http://www.readysetrails.com/index.php/2111/5-mistakes-that-make-you-look-like-a-rails-n00b/
alias gwc='git whatchanged -p --abbrev-commit --pretty=medium'
alias gg='git log --no-merges --pretty=format:"%C(yellow)%h%Creset%Cgreen%d%Creset %s"'
alias gco='git checkout'
complete -o default -o nospace -F _git_checkout gco
alias grm="git status | grep deleted | awk '{print \$3}' | xargs git rm"
alias gps='git svn dcommit'
alias gls='git svn rebase'
alias gh='git stash'
alias ghp='git stash pop'

# rails
alias r='bundle exec rails'
alias bake='bundle exec rake'
alias be='bundle exec'
alias beg='bundle exec guard'
alias rr='rake routes | grep'
alias mig='bundle exec rake db:migrate db:test:clone'
alias rs='touch tmp/restart.txt'
alias ss='ruby script/server'
alias sc='ruby script/console'

# tailing logs
alias t='tail -fn100 log/development.log'
alias td="tail -fn100 log/development.log | grep '###'"

# misc
alias vhosts='sudo vim /etc/hosts'
alias rss='sudo service apache2 restart'

# vim
alias v='vim'

# bash
alias x='exit'
alias a='ack-grep'
alias nh='telnet nethack.alt.org'
