# ls
alias ll='ls -GFalh'
alias la='ls -GFA'
alias l='ls -GF1'

# cd
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# grep
alias grep='grep --color=auto'
alias rgrep='grep -r'

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
