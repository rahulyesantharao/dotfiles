#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# VARIABLES
export GREP_OPTIONS=' - color=auto' # color in grep
export EDITOR=vim

# COMMON COMMANDS
alias ls='ls --color=auto'
alias ll='ls -laiF --color=auto --group-directories-first'
alias cls='clear; ls'
alias cll='clear; ll'
alias grep='grep --color=auto'

# GIT
alias g='git'

# PERSONALIZATION
PS1='[\u@\h \W]\$ '
alias notes='vim ~/notes.txt'
