# History in cache directory:
export HISTSIZE=10000000    # history lines stored in memory
export SAVEHIST=10000000    # history lines stored on disk
export HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"

setopt extended_history
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_find_no_dups
setopt hist_save_no_dups
