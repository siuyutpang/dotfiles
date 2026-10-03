# History in cache directory:
export HISTSIZE=10000000    # history lines stored in memory
export SAVEHIST=10000000    # history lines stored on disk
export HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"
export HISTORY_IGNORE="(pwd|exit|proxy\
|poweroff|reboot\
|..|cd|cd *|ll|ls|ls *\
|d|1|2|3|4|5|6|7|8|9\
|r|yy|z|z *|v|v *\
|mkcd *|cdtmp\
|cp *|mv *|rm *\
|./ *)"

setopt hist_verify
setopt extended_history
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_expire_dups_first
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_find_no_dups
setopt hist_save_no_dups
