#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

stty -ixon    # disable ctrl-s and ctrl-q

shopt -s autocd
shopt -s direxpand

set -o vi

export HISTSIZE=-1
export HISTFILESIZE=-1
export HISTTIMEFORMAT="%F %R "
export HISTFILE="$HOME/.cache/bash/history"
export HISTCONTROL="erasedups:ignoreboth"

export PS1="\[\e[1;31m\][\[\e[1;33m\]\u\[\e[1;32m\]@\[\e[1;34m\]\h \[\e[1;35m\]\W\[\e[1;31m\]]\[\e[0m\]\$ \[\e[0m\]"

# load shell-agnostic stuff
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/arsenal" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/arsenal"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/environ" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/environ"

# load bash-specific stuff
source /usr/share/fzf/completion.bash
source /usr/share/fzf/key-bindings.bash
