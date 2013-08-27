# ls
alias ls='ls -GFh'
alias ll='ls -al'
alias la='ls -A'
alias l='ls -1'

# cd
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# grep
alias grep='grep --color=auto'
alias rgrep='grep -r'

# less
alias less='less -R'

# vim
alias v='vim'

# bash
alias x='exit'

# rails
alias r='bundle exec rails'
alias k='bundle exec rake'
alias t='bundle exec guard'
alias sc='ruby script/console'
alias taill='tail -fn100 log/development.log'
alias taillg="tail -fn100 log/development.log | grep '###'"
alias rs='touch tmp/restart.txt'
alias dbload='~/code/binfiles/dbload'
