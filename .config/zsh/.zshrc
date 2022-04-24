autoload -U colors && colors	# Load colors

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/.zsh_history

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
#zstyle ':completion:*' matcher-list \
#	    'm:{[:lower:]}={[:upper:]}' \
#	        '+r:|[._-]=* r:|=*' \
#		    '+l:|=*'
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

#Vi mode
bindkey -v
export KEYTIMEOUT=1

# Edit line in vim buffer ctrl-v
autoload edit-command-line; zle -N edit-command-line
bindkey '^v' edit-command-line
# Enter vim buffer from normal mode
autoload -U edit-command-line && zle -N edit-command-line && bindkey -M vicmd "^v" edit-command-line

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[2 q';;      # block
        viins|main) echo -ne '\e[6 q';; # beam
    esac
}
zle -N zle-keymap-select
# zle-line-init() {
#     zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
#     echo -ne "\e[6 q"
# }
# zle -N zle-line-init
# echo -ne '\e[6 q' # Use beam shape cursor on startup.
# preexec() { echo -ne '\e[6 q' ;} # Use beam shape cursor for each new prompt.

# _fix_cursor() {
#   echo -ne '\e[6 q'
# }
# precmd_functions+=(_fix_cursor)

# Load aliases if existent.
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"

# Load environment varibles if existent.
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/env" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/env"

# autojump configuration
[[ -s /etc/profile.d/autojump.sh ]] && source /etc/profile.d/autojump.sh

# some nice functions
source ~/.config/zsh/functions/functions.zsh

# plugins
source "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh"
source "/usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
source "/usr/share/doc/pkgfile/command-not-found.zsh"

eval "$(starship init zsh)"
