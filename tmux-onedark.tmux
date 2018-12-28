#!/bin/bash
onedark_black="#282c34"
onedark_blue="#61afef"
onedark_yellow="#e5c07b"
onedark_red="#e06c75"
onedark_white="#aab2bf"
onedark_green="#98c379"
onedark_visual_grey="#3e4452"
onedark_comment_grey="#5c6370"

setr() {
  local option=$1
  local value=$2
  tmux set-option -gq "$option" "$value"
}

setw() {
  local option=$1
  local value=$2
  tmux set-window-option -gq "$option" "$value"
}

setr "message-fg" "$onedark_white"
setr "message-bg" "$onedark_black"

setr "message-command-fg" "$onedark_white"
setr "message-command-bg" "$onedark_black"

setw "window-status-fg" "$onedark_black"
setw "window-status-bg" "$onedark_black"

setw "window-status-activity-bg" "$onedark_black"
setw "window-status-activity-fg" "$onedark_black"

setr "window-style" "fg=$onedark_comment_grey,bg=$onedark_black"
setr "window-active-style" "fg=$onedark_white,bg=$onedark_black"

setr "pane-border-fg" "$onedark_white"
setr "pane-active-border-fg" "$onedark_white"

setr "display-panes-active-colour" "$onedark_yellow"
setr "display-panes-colour" "$onedark_blue"

setr "status-bg" "$onedark_black"
setr "status-fg" "$onedark_white"

status_widgets=""
time_format="%R"
date_format="%d/%m/%Y"

setr "status-right" "#[fg=$onedark_white,bg=$onedark_black,nounderscore,noitalics]${time_format}  ${date_format} #[fg=$onedark_visual_grey,bg=$onedark_black]#[fg=$onedark_visual_grey,bg=$onedark_visual_grey]#[fg=$onedark_white, bg=$onedark_visual_grey]${status_widgets} #[fg=$onedark_green,bg=$onedark_visual_grey,nobold,nounderscore,noitalics]#[fg=$onedark_black,bg=$onedark_green,bold] #h #[fg=$onedark_yellow, bg=$onedark_green]#[fg=$onedark_red,bg=$onedark_yellow]"

setr "status-left" "#[fg=$onedark_visual_grey,bg=$onedark_green,bold] #S #{prefix_highlight}#[fg=$onedark_green,bg=$onedark_black,nobold,nounderscore,noitalics]"

setr "window-status-format" "#[fg=$onedark_black,bg=$onedark_black,nobold,nounderscore,noitalics]#[fg=$onedark_white,bg=$onedark_black] #I  #W #[fg=$onedark_black,bg=$onedark_black,nobold,nounderscore,noitalics]"
setr "window-status-current-format" "#[fg=$onedark_black,bg=$onedark_visual_grey,nobold,nounderscore,noitalics]#[fg=$onedark_white,bg=$onedark_visual_grey,nobold] #I  #W #[fg=$onedark_visual_grey,bg=$onedark_black,nobold,nounderscore,noitalics]"
