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

# Use pip without requiring virtualenv
syspip() {
  PIP_REQUIRE_VIRTUALENV="" pip "$@"
}

syspip2() {
  PIP_REQUIRE_VIRTUALENV="" pip2 "$@"
}

syspip3() {
  PIP_REQUIRE_VIRTUALENV="" pip3 "$@"
}

# personal
alias notes='vim ~/notes.txt'

# unzip/zip
targz() { tar -zcvf $1.tar.gz $1; }
x() {
    if [ -f $1 ] ; then
            case $1 in
                    *.tar.bz2)   tar xvjf $1    ;;
                    *.tar.gz)    tar xvzf $1    ;;
                    *.bz2)       bunzip2 $1     ;;
                    *.rar)       unrar x $1     ;;
                    *.gz)        gunzip $1      ;;
                    *.tar)       tar xvf $1     ;;
                    *.tbz2)      tar xvjf $1    ;;
                    *.tgz)       tar xvzf $1    ;;
                    *.zip)       unzip $1       ;;
                    *.Z)         uncompress $1  ;;
                    *.7z)        7z x $1        ;;
                    *)           echo "Unable to extract '$1'" ;;
            esac
    else
            echo "'$1' is not a valid file"
    fi
}

# from default bashrc
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
# from default bashrc
#alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

