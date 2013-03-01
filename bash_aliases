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
