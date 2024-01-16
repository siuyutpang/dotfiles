# fpath+=${XDG_CONFIG_HOME}/zsh/comp.d

autoload -U colors && colors	   # Load colors

stty stop undef		               # Disable ctrl-s to freeze terminal.
zle_highlight=('paste:none')       # disable highlighting pasted text
unsetopt flowcontrol
# setopt correct
setopt interactive_comments
ZLE_REMOVE_SUFFIX_CHARS=$' \t\n;&' # more details can view through man zshparam

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
#
# _fix_cursor() {
#   echo -ne '\e[6 q'
# }
# precmd_functions+=(_fix_cursor)

# load lib files
if [ -d ~/.config/zsh/lib ]; then
    for lib_file in ~/.config/zsh/lib/*.zsh(N); do
        [ -e "$lib_file" ] && source "$lib_file"
    done
    unset lib_file
fi

# load plugins
if [ -d ~/.config/zsh/plugins ]; then
    for plugin in ~/.config/zsh/plugins/*.zsh(N); do
        [ -e "$plugin" ] && source "$plugin"
    done
    unset plugin
fi

# load shell-agnostic stuff
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/arsenal" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/arsenal"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/environ" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/environ"

# plugins
source /usr/share/doc/pkgfile/command-not-found.zsh 2>/dev/null
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh 2>/dev/null
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null

# load zsh-specific stuff
source ~/.config/zsh/setup
