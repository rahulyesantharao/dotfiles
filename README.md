# Dotfiles
Clone with `git clone --recurse-submodules` to get the submodules.
In order to include this on a computer, do `cd dotfiles && ./install` in a terminal.

## Notes
 - Assumes the terminal has 24-bit truecolor support
 - Assumes `tmux` version >= 2.2
 - Assumes `$TERM` is `term-256color`; if not, update [`tmux.conf`](tmux.conf) appropriately.
 - `tmux` and `bash` prompt use [powerline](https://github.com/powerline/fonts) patched font. If not,
   - Switch characters in [`tmux-onedark.tmux`](tmux-onedark.tmux)
   - Switch `PL_SYMBOLS` in [`prompt.bash`](bash/prompt.bash)
