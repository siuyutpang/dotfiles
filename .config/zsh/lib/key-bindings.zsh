#Vi mode
bindkey -v
export KEYTIMEOUT=1

# Edit line in vim with ctrl-v
autoload edit-command-line; zle -N edit-command-line
bindkey '^v' edit-command-line
bindkey -M vicmd '^v' edit-command-line

# Fix delete and backword
bindkey "^[[3~" delete-char
bindkey '^?' backward-delete-char

# Emacs-like style shortcuts
bindkey '^k' kill-line
bindkey '^u' backward-kill-line
bindkey '^y' yank

bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
bindkey '^q' push-line-or-edit    # eq: Ctrl + U then Ctrl + Y in emacs mode

exit_zsh() { exit }
zle -N exit_zsh
bindkey '^D' exit_zsh
