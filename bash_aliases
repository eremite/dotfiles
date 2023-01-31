# Set language env variables.
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US:en
export LC_MESSAGES=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_COLLATE=en_US.UTF-8
export TZ='America/Denver'
export DOCKER_SCAN_SUGGEST=false

# https://github.com/junegunn/fzf
export FZF_DEFAULT_OPTS="--reverse --inline-info"

# Add ./bin to PATH
PATH="$PATH:./bin"

HISTSIZE=100000
HISTFILESIZE=20000

# Git tab completion
file=$HOME/dotfiles/git-completion.bash && test -f $file && source $file
__git_complete g __git_main # Enable it for `g` alias

# Git prompt
file=$HOME/dotfiles/git-prompt.sh && test -f $file && source $file
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

curl --silent --max-time 0.01 http://169.254.169.254/latest/meta-data/instance-id > /dev/null
if [ $? -eq 0 ]; then
  export META_DIRECTORY="/tmp/meta/"
  mkdir -p $META_DIRECTORY
else
  export META_DIRECTORY="/mnt/chromeos/GoogleDrive/MyDrive/project_notes/"
fi

function n {
  cat notes.md
}
function N {
  cat notes.rb
}

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


# misc
alias g='git'
alias grep='grep --color=auto'
alias less='less -R'
alias rgrep='grep -r'
alias x='exit'
alias v="vim"
alias V="vim notes.md"
alias n="cat notes.md"
alias N="cat notes.rb"

# docker rails app
alias d='docker system prune --volumes --force'
alias dc="docker compose"
alias log='dc logs -f --tail=100'
alias logg='dc logs -f --tail=100 | grep "##"'
alias r="docker compose exec web rails"
alias rails="docker compose exec web rails"
alias reup="docker compose down; docker system prune --volumes --force; docker compose build; docker compose up --detach; bin/setup"
alias rs="docker compose stop web sidekiq; docker compose rm -f web sidekiq; docker compose up --detach"
alias run="docker compose exec web"
alias t="docker compose exec web bash -c 'rubocop -P && yamllint --strict . && haml-lint && yarn lint && rails test && brakeman -A'"
alias up="docker compose up --detach"
alias down="docker compose stop; docker compose rm --force"
alias penguin="ngrok http 80 --subdomain=penguin"
alias aws='docker run --rm -ti -v ~/.aws:/root/.aws -v $(pwd):/aws amazon/aws-cli'
alias tunnel='ngrok start core test demo --log=stdout > log/ngrok.log &'
