#Vi mode
bindkey -v
export KEYTIMEOUT=1

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
bindkey -M vicmd '^e' edit-command-line

bindkey '^k' kill-line
bindkey '^u' backward-kill-line
bindkey '^y' yank

# fix delete and backword
bindkey "^[[3~" delete-char
bindkey '^?' backward-delete-char

bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

bindkey '^a' beginning-of-line
bindkey '^q' push-line-or-edit    # eq: Ctrl + U then Ctrl + Y in emacs mode

bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

exit_zsh() { exit }
zle -N exit_zsh
bindkey '^D' exit_zsh
