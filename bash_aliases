# Set language env variables.
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US:en
export LC_MESSAGES=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_COLLATE=en_US.UTF-8
export TZ='America/Denver'

# https://github.com/junegunn/fzf
export FZF_DEFAULT_OPTS="--reverse --inline-info"

export DATA="$HOME"

# Add ./bin to PATH
PATH="$PATH:./bin"

HISTSIZE=100000
HISTFILESIZE=20000

# Git tab completion
file=$DATA/dotfiles/git-completion.bash && test -f $file && source $file
__git_complete g __git_main # Enable it for `g` alias

# Git prompt
file=$DATA/dotfiles/git-prompt.sh && test -f $file && source $file
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWUPSTREAM="verbose"
PROMPT_COMMAND='__git_ps1 "\w" "\\\$ "'

# Start ssh-agent http://mah.everybody.org/docs/ssh#run-ssh-agent
SSH_ENV="$HOME/.ssh/environment"
function start_agent {
  echo "Initialising new SSH agent..."
  /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
  echo succeeded
  chmod 600 "${SSH_ENV}"
  . "${SSH_ENV}" > /dev/null
  /usr/bin/ssh-add;
}
if [ -f "${SSH_ENV}" ]; then
  . "${SSH_ENV}" > /dev/null
  ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
    start_agent;
  }
else
   start_agent;
fi

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
alias rgrep='grep -r'

# less
alias less='less -R'

# vim
alias v="TERM=xterm-256color nvim"

# bash
alias x='exit'

# rails
alias a="docker-compose exec web"
alias r="docker-compose exec web rails"
alias z="docker-compose exec web bash -c 'rails test && rubocop && yarn test stylelint'"

# git
alias g='git'
