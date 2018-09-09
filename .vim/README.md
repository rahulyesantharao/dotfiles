# Vim Dotfiles
In order to include this on a computer, do the following two commands in bash:
```
cd
ln -s dotfiles/.vim
ln -s dotfiles/.vim/.vimrc
```
Make sure
```
set -g default-terminal "screen-256color"
```
is set in `.tmux.conf` if you want to use `tmux`.
