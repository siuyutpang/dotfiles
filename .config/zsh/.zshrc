# Sy's config for the Zoomer Shell

# Load all of the lib files in $ZDOTDIR/lib that end in .zsh
if [ -d ~/.config/zsh/lib ]; then
    for lib_file in ~/.config/zsh/lib/*.zsh(N); do
        [ -e "$lib_file" ] && source "$lib_file"
    done
    unset lib_file
fi

# Load all of the plugins in $ZDOTDIR/plugins that end in .zsh
if [ -d ~/.config/zsh/plugins ]; then
    for plugin in ~/.config/zsh/plugins/*.zsh(N); do
        [ -e "$plugin" ] && source "$plugin"
    done
    unset plugin
fi

# Load shell-agnostic stuff
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/arsenal" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/arsenal"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/environ" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/environ"

# Load awesome zsh plugins
source /usr/share/doc/pkgfile/command-not-found.zsh 2>/dev/null
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh 2>/dev/null
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null

# Load zsh-specific stuff
source ~/.config/zsh/setup
