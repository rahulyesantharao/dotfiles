# use color in coreutils utilities (assume dircolor)
alias ls='ls --color=auto'
#alias dir='dir --color=auto'
#alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# ls aliases
alias l='ls -CF'
alias ll='ls -alFh --group-directories-first'
alias la='ls -A'
alias cls='clear; ls'
alias cll='clear; ll'

# safety aliases
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# common command aliases
alias g='git'
alias c='clear'
alias loadrc='source $HOME/.bashrc'

# go up [n] directories
up()
{
  local cdir="$(pwd)"
  if [[ "${1}" == "" ]]; then
    cdir="$(dirname "${cdir}")"
  elif ! [[ "${1}" =~ ^[0-9]+$ ]]; then
    echo "Error: argument must be a number"
  elif ! [[ "${1}" -gt "0" ]]; then
    echo "Error: argument must be positive"
  else
    for ((i=0; i<${1}; i++)); do
      local ncdir="$(dirname "${cdir}")"
      if [[ "${cdir}" == "${ncdir}" ]]; then
        break
      else
        cdir="${ncdir}"
      fi
    done
  fi
  cd "${cdir}"
}

# personal
alias notes='vim ~/notes.txt'

# from default bashrc
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
# from default bashrc
#alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


