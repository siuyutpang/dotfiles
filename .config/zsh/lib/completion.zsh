# fpath+=${XDG_CONFIG_HOME}/zsh/comp.d

# Basic auto/tab complete:
autoload -U compinit

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

zmodload zsh/complist
compinit -C -d "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump-$ZSH_VERSION"

# Include hidden files.
_comp_options+=(globdots)
