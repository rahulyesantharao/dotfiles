# HISTORY #############################################
# - histsize/histfilesize explanation: https://stackoverflow.com/questions/19454837/bash-histsize-vs-histfilesize
#######################################################
HISTCONTROL=ignoreboth # don't put duplicate lines or lines starting with space in the history.
HISTSIZE=1048576
#HISTFILESIZE=2000
HISTFILE="$HOME/.bash_history"
HISTTIMEFORMAT="%m/%d %T: "
shopt -s histappend # append to the history file

# BASH COMPLETION #####################################
# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
#######################################################
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Other Options #######################################
shopt -s checkwinsize # update LINES/COLUMNS if window resizes
#shopt -s globstar # "**" will match all files, >= directories

# Settings Exports ####################################
export EDITOR=vim
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)" # make less more friendly for non-text input files
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01' # colored GCC warnings/errors

