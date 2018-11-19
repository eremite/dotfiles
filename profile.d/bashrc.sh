export DATA="$HOME"
export META="$DATA/meta"

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

# Shortcut for getting to meta
meta() {
  current_directory=`basename $(pwd)`
  if [ -d "$META/$current_directory" ]; then
    cd "$META/$current_directory"
  else
    cd $META
  fi
}

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

# Bash Aliases

file=$HOME/.bash_aliases && test -f $file && source $file

# https://github.com/junegunn/fzf
export FZF_DEFAULT_OPTS="--reverse --inline-info"

# Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
