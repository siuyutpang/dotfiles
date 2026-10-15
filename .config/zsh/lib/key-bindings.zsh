#Vi mode
bindkey -v
export KEYTIMEOUT=1

# Edit line in vim with ctrl-g
autoload edit-command-line; zle -N edit-command-line
bindkey -M viins '^g' edit-command-line
bindkey -M vicmd '^g' edit-command-line

bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

bindkey '^q' push-line-or-edit    # eq: Ctrl + U then Ctrl + Y in emacs mode

autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

# Fix: Ctrl+D close shell even if command line is filled.
exit_zsh() { exit }
zle -N exit_zsh
bindkey '^D' exit_zsh

# Fix: Ctrl+L still can scrollback buffer after clear screen.
scroll-and-clear-screen() {
    printf '\n%.0s' {1..$LINES}
    zle clear-screen
}
zle -N scroll-and-clear-screen
bindkey '^l' scroll-and-clear-screen
