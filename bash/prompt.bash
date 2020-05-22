# taken from: https://github.com/chris-marsh/pureline

# DEFAULTS ############################################
# Color Set
declare -A PL_COLORS=(
[Color_Off]='\[\e[0m\]'       # Text Reset
# Foreground
[Default]='\[\e[0;39m\]'               # Default
[Black]='\[\e[38;2;40;44;52m\]'        # Black
[Red]='\[\e[38;2;224;108;117m\]'       # Red
[Green]='\[\e[38;2;152;195;121m\]'     # Green
[Yellow]='\[\e[38;2;229;192;123m\]'    # Yellow
[Blue]='\[\e[38;2;97;195;239m\]'       # Blue
[Purple]='\[\e[38;2;198;120;221m\]'    # Purple
[Cyan]='\[\e[38;2;86;182;194m\]'       # Cyan
[White]='\[\e[38;2;171;178;191m\]'     # White
# Background
[On_Default]='\[\e[49m\]'              # Default
[On_Black]='\[\e[48;2;40;44;52m\]'     # Black
[On_Red]='\[\e[48;2;224;108;117m\]'    # Red
[On_Green]='\[\e[48;2;152;195;121m\]'  # Green
[On_Yellow]='\[\e[48;2;229;192;123m\]' # Yellow
[On_Blue]='\[\e[48;2;97;195;239m\]'    # Blue
[On_Purple]='\[\e[48;2;198;120;221m\]' # Purple
[On_Cyan]='\[\e[48;2;86;182;194m\]'    # Cyan
[On_White]='\[\e[48;2;171;178;191m\]'  # White
)

# Character Set
declare -A PL_SYMBOLS=(
[hard_separator]=""
[soft_separator]="│"

[git_branch]="╬"
[git_untracked]="?"
[git_stash]="§"
[git_ahead]="↑"
[git_behind]="↓"
[git_modified]="+"
[git_staged]="•"
[git_conflicts]="*"

[ssh]="╤"
[read_only]="Θ"
[return_code]="x"
[background_jobs]="↨"
[background_jobs]="↔"
[python]="π"

[battery_charging]="■ "
[battery_discharging]="▬ "
)

# Modules
declare -a PL_MODULES=(
#module             BG          FG
#'time_module        Green       Black'
'user_module        Blue        Black'
'ssh_module         Green       Black'
'virtual_env_module Yellow      Black'
'path_module        Purple      Black'
'git_module         White       Black'
'return_code_module Red         Black'
'newline_module'
'prompt_module      Cyan        Black'
)

# Options
PL_TIME_SHOW_SECONDS=false

PL_USER_SHOW_HOST=true
PL_USER_SHOW_IP=false

PL_SSH_SHOW_HOST=true
PL_SSH_SHOW_IP=false

PL_PATH_TRIM=0

PL_GIT_DIRTY_FG=Black
PL_GIT_DIRTY_BG=Yellow
PL_GIT_STASH=false
PL_GIT_AHEAD=true
PL_GIT_STAGED=false
PL_GIT_CONFLICTS=false
PL_GIT_MODIFIED=false
PL_GIT_UNTRACKED=false

[[ $(bind -v) =~ "set show-mode-in-prompt off" ]] && PL_ERASE_TO_EOL=true
######################################################
# UTILITIES ##########################################

# -----------------------------------------------------------------------------
# returns a string with the powerline symbol for a section end
# arg: $1 is foreground color of the next section
# arg: $2 is background color of the next section
section_end() {
  if [ "$__last_color" == "$2" ]; then
    # Section colors are the same, use a foreground separator
    local end_char="${PL_SYMBOLS[soft_separator]}"
    local fg="$1"
  else
    # section colors are different, use a background separator
    local end_char="${PL_SYMBOLS[hard_separator]}"
    local fg="$__last_color"
  fi
  if [ -n "$__last_color" ]; then
    echo "${PL_COLORS[$fg]}${PL_COLORS[On_$2]}$end_char"
  fi
}

# -----------------------------------------------------------------------------
# returns a string with background and foreground colours set
# arg: $1 foreground color
# arg: $2 background color
# arg: $3 content
section_content() {
  echo "${PL_COLORS[$1]}${PL_COLORS[On_$2]}$3"
}

#------------------------------------------------------------------------------
# Helper function to return normal or super user prompt character
prompt_char() {
  [[ ${EUID} -eq 0 ]] && echo "#" || echo "$"
}

######################################################
# MODULES ############################################

# -----------------------------------------------------------------------------
# append to prompt: current time
# arg: $1 foreground color
# arg: $2 background color
# optional variables;
#   PL_TIME_SHOW_SECONDS: true/false for hh:mm:ss / hh:mm
time_module() {
  local bg_color="$1"
  local fg_color="$2"
  if [ "$PL_TIME_SHOW_SECONDS" = true ]; then
    local content="\t"
  else
    local content="\A"
  fi
  PS1+="$(section_end $fg_color $bg_color)"
  PS1+="$(section_content $fg_color $bg_color " $content ")"
  __last_color="$bg_color"
}

#------------------------------------------------------------------------------
# append to prompt: user@host or user or root@host
# arg: $1 foreground color
# arg: $2 background color
# option variables;
#   PL_USER_SHOW_HOST: true/false to show host name/ip
#   PL_USER_USE_IP: true/false to show IP instead of hostname
user_module() {
  local bg_color="$1"
  local fg_color="$2"
  local content="\u"
  # Show host if true or when user is remote/root
  if [ "$PL_USER_SHOW_HOST" = true ]; then
    if [ "$PL_USER_USE_IP" = true ]; then
      content+="@$(ip_address)"
    else
      content+="@\h"
    fi
  fi
  PS1+="$(section_end $fg_color $bg_color)"
  PS1+="$(section_content $fg_color $bg_color " $content ")"
  __last_color="$bg_color"
}

# -----------------------------------------------------------------------------
# append to prompt: indicate if SSH session
# arg: $1 foreground color
# arg: $2 background color
# option variables;
#   PL_SSH_SHOW_HOST: true/false to show host name/ip
#   PL_SSH_USE_IP: true/false to show IP instead of hostname
ssh_module() {
  if [[ "${SSH_CLIENT}" || "${SSH_TTY}" ]]; then
    local bg_color="$1"
    local fg_color="$2"
    local content="${PL_SYMBOLS[ssh]}"
    if [ "$PL_SSH_SHOW_HOST" = true ]; then
      if [ "$PL_SSH_USE_IP" = true ]; then
        content+=" $(ip_address)"
      else
        content+=" \h"
      fi
    fi
    PS1+="$(section_end $fg_color $bg_color)"
    PS1+="$(section_content $fg_color $bg_color " $content ")"
    __last_color="$bg_color"
  fi
}

# -----------------------------------------------------------------------------
# append to prompt: current directory
# arg: $1 foreground color
# arg; $2 background color
# option variables;
#   PL_PATH_TRIM: 0—fullpath, 1—current dir, [x]—trim to x number of dir
path_module() {
  local bg_color="$1"
  local fg_color="$2"
  local content="\w"
  if [ "$PL_PATH_TRIM" -eq 1 ]; then
    local content="\W"
  elif [ "$PL_PATH_TRIM" -gt 1 ]; then
    PROMPT_DIRTRIM="$PL_PATH_TRIM"
  fi
  PS1+="$(section_end $fg_color $bg_color)"
  PS1+="$(section_content $fg_color $bg_color " $content ")"
  __last_color="$bg_color"
}

# -----------------------------------------------------------------------------
# append to prompt: git branch with indictors for;
#     number of; modified files, staged files and conflicts
# arg: $1 foreground color
# arg; $2 background color
# option variables;
#   PL_GIT_DIRTY_FG: <color>
#   PL_GIT_DIRTY_BG: <color>
#   PL_GIT_STASH: true/false
#   PL_GIT_AHEAD: true/false
#   PL_GIT_STAGED: true/false
#   PL_GIT_CONFLICTS: true/false
#   PL_GIT_MODIFIED: true/false
#   PL_GIT_UNTRACKED: true/false
git_module() {
local git_branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
  if [ -n "$git_branch" ]; then
    local bg_color="$1"
    local fg_color="$2"
    local content="${PL_SYMBOLS[git_branch]} $git_branch"

#    if [ "$PL_GIT_STASH" = true ]; then
#      local number_stash="$(git stash list 2>/dev/null | wc -l)"
#      if [ ! "$number_stash" -eq 0 ]; then
#        content+="${PL_SYMBOLS[git_stash]}$number_stash"
#      fi
#    fi
#
    if [ "$PL_GIT_AHEAD" = true ]; then
      local number_ahead="$(git rev-list --count --right-only '@{upstream}...HEAD' 2>/dev/null)"
      local number_behind="$(git rev-list --count --left-only '@{upstream}...HEAD' 2>/dev/null)"
      if [ ! "0$number_ahead" -eq 0 -o ! "0$number_behind" -eq 0 ]; then
        if [ ! "$number_ahead" -eq 0 ]; then
          content+="${PL_SYMBOLS[git_ahead]}$number_ahead"
        fi
        if [ ! "$number_behind" -eq 0 ]; then
          content+="${PL_SYMBOLS[git_behind]}$number_behind"
        fi
      fi
    fi
#
#    if [ "$PL_GIT_STAGED" = true ]; then
#      local number_staged="$(git diff --staged --name-only --diff-filter=AM 2> /dev/null | wc -l)"
#      if [ ! "$number_staged" -eq "0" ]; then
#        content+=" ${PL_SYMBOLS[soft_separator]} ${PL_SYMBOLS[git_staged]}$number_staged"
#      fi
#    fi
#
#    if [ "$PL_GIT_CONFLICTS" = true ]; then
#      local number_conflicts="$(git diff --name-only --diff-filter=U 2> /dev/null | wc -l)"
#      if [ ! "$number_conflicts" -eq "0" ]; then
#        content+=" ${PL_SYMBOLS[soft_separator]} ${PL_SYMBOLS[git_conflicts]}$number_conflicts"
#      fi
#    fi
#
#    if [ "$PL_GIT_MODIFIED" = true ]; then
#      local number_modified="$(git diff --name-only --diff-filter=M 2> /dev/null | wc -l )"
#      if [ ! "$number_modified" -eq "0" ]; then
#        content+=" ${PL_SYMBOLS[soft_separator]} ${PL_SYMBOLS[git_modified]}$number_modified"
#      fi
#    fi
#
#    if [ "$PL_GIT_UNTRACKED" = true ]; then
#      local number_untracked="$(git ls-files --other --exclude-standard | wc -l)"
#      if [ ! "$number_untracked" -eq "0" ]; then
#        content+=" ${PL_SYMBOLS[soft_separator]} ${PL_SYMBOLS[git_untracked]}$number_untracked"
#      fi
#    fi
#
    if [ -n "$(git status --porcelain)" ]; then
      if [ -n "$PL_GIT_DIRTY_FG" ]; then
        fg_color="$PL_GIT_DIRTY_FG"
      fi
      if [ -n "$PL_GIT_DIRTY_BG" ]; then
        bg_color="$PL_GIT_DIRTY_BG"
      fi
    fi

    PS1+="$(section_end $fg_color $bg_color)"
    PS1+="$(section_content $fg_color $bg_color " $content ")"
    __last_color="$bg_color"
  fi
}

# -----------------------------------------------------------------------------
# append to prompt: python virtual environment name
# arg: $1 foreground color
# arg; $2 background color
virtual_env_module() {
  # advanced check if in virtualenv
#  if command -v python &>/dev/null; then
#    INVENV=$(python -c 'import sys; print ("1" if hasattr(sys, "real_prefix") else "0")')
#  elif command -v python3 &>/dev/null; then
#    INVENV=$(python3 -c 'import sys; print ("1" if hasattr(sys, "real_prefix") else "0")')
#  else
#    if [ -n "$VIRTUAL_ENV" ]; then
#      INVENV=1
#    else
#      INVENV=0
#  fi
  if [ -n "$VIRTUAL_ENV" ]; then
    local venv="${VIRTUAL_ENV##*/}"
    local bg_color="$1"
    local fg_color="$2"
    local content=" ${PL_SYMBOLS[python]} $venv"
    PS1+="$(section_end $fg_color $bg_color)"
    PS1+="$(section_content $fg_color $bg_color "$content ")"
    __last_color="$bg_color"
  fi
}

# -----------------------------------------------------------------------------
# append to prompt: append a '$' prompt with optional return code for previous command
# arg: $1 foreground color
# arg; $2 background color
prompt_module() {
  local bg_color="$1"
  local fg_color="$2"
  local content=" $(prompt_char) "
  #PS1+="$(section_end $fg_color $bg_color)"
  #PS1+="$(section_content $fg_color $bg_color "$content")"
  PS1+="$content"
  __last_color="$bg_color"
}

# -----------------------------------------------------------------------------
# append to prompt: append a '$' prompt with optional return code for previous command
# arg: $1 foreground color
# arg; $2 background color
return_code_module() {
  if [ ! "$__return_code" -eq 0 ]; then
    local bg_color="$1"
    local fg_color="$2"
    local content=" ${PL_SYMBOLS[return_code]} $__return_code "
    PS1+="$(section_end $fg_color $bg_color)"
    PS1+="$(section_content $fg_color $bg_color "$content")"
    __last_color="$bg_color"
  fi
}

# -----------------------------------------------------------------------------
# append to prompt: end the current promptline and start a newline
newline_module() {
  if [ -n "$__last_color" ]; then
    PS1+="$(section_end $__last_color 'Default')"
  fi
  PS1+="${PL_COLORS[Color_Off]}"
  PS1+="\n"
  unset __last_color
}

######################################################
# PURELINE PROMPT ####################################
# -----------------------------------------------------------------------------
function pureline_ps1 {
  __return_code=$?    # save the return code
  PS1=""              # reset the command prompt

  # load the modules
  for module in "${!PL_MODULES[@]}"; do
    ${PL_MODULES[$module]}
  done

  # final end point
#  if [ -n "$__last_color" ]; then
#    PS1+="$(section_end $__last_color 'Default')"
#  else
  if [ ! -n "$__last_color" ]; then
    # No modules loaded, set a basic prompt
    PS1="PL | No Modules Loaded: $(prompt_char)"
  fi

  # cleanup
  PS1+="${PL_COLORS[Color_Off]}"
  if [ "$PL_ERASE_TO_EOL" = true ]; then
    PS1+="\[\e[K\]"
  fi
  #PS1+=" "
  unset __last_color
  unset __return_code
}

# grab a snapshot of the systems PROMPT_COMMAND. this can then be
# appended to pureline when sourced without continually appending
# pureline to itself.
if [ -z "$__PROMPT_COMMAND" ]; then 
__PROMPT_COMMAND="$PROMPT_COMMAND"
fi

# dynamically set the PS1
[[ ! ${PROMPT_COMMAND} =~ 'pureline_ps1;' ]] &&  PROMPT_COMMAND="pureline_ps1; $PROMPT_COMMAND" || true
