# ls
alias ls='ls --color=auto -GFh'
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

# less
alias less='less -R'

# vim
alias v='vim'

# bash
alias x='exit'

# rails
if [ -f "$DATA/docker_rails_app/docker_rails_app.sh" ]; then
  alias a="$DATA/docker_rails_app/docker_rails_app.sh"
fi

# git
alias g='git'
