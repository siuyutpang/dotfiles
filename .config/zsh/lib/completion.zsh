# Completion initialization is handled by znap.

setopt complete_in_word
setopt always_to_end
setopt menu_complete

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list \
    'm:{[:lower:]}={[:upper:]}' \
    '+r:|[._-]=* r:|=*' \
    '+l:|=*'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Include hidden files.
setopt globdots
# _comp_options+=(globdots)
