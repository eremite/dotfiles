# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
HISTFILESIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
  xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
    color_prompt=yes
  else
    color_prompt=
  fi
fi

if [ "$color_prompt" = yes ]; then
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# Shows the current git branch in your shell prompt
function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
}

# Only show working directory in prompt
PS1='\w$(parse_git_branch)$ '

# If this is an xterm set the title to the working directory
case "$TERM" in
  xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\W\a\]$PS1"
    ;;
  *)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
  . /etc/bash_completion
fi


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

# Get a new project from git and symlink it to ~/code
function get {
  project=${1/.git/}
  git clone ssh://git.mokisystems.com/var/repos/${project}.git /media/sdb1/${project}
  cd ~/code
  ln -sf /media/sdb1/${project}
  cd ${project}
  if [ -e "config/database.yml.example" ]; then
    cp config/database.yml{.example,}
  fi
  cat > ${project} <<HEREDOC
<VirtualHost *:80>
  RailsEnv development
  ServerName ${project}.daniel.lin
  ServerAlias ${project:0:3}.daniel.lin
  DocumentRoot /home/daniel/${project}/public
</VirtualHost>
HEREDOC
  sudo mv ${project} /etc/apache2/sites-available
  sudo a2ensite ${project}
  sudo /usr/sbin/apache2ctl graceful
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

# Jump to ~/code from anywhere (with tab completion!)
function c {
  cd ~/code/$1
}
function _c {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  COMPREPLY=( $(compgen -d -S '/' ~/code/${cur} | cut -d '/' -f 5-) )
}
complete -o nospace -F _c c

# Jump to ~/gits from anywhere (with tab completion!)
function g {
  cd ~/gits/$1
}
function _g {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  COMPREPLY=( $(compgen -d -S '/' ~/gits/${cur} | cut -d '/' -f 5-) )
}
complete -o nospace -F _g g

# Map Caps Lock to ESC
xmodmap -e "clear lock"
xmodmap -e "keycode 0x42 = Escape"
