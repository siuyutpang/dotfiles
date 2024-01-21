# Sy's config for the Zoomer Shell

source ~/.local/share/znap/zsh-snap/znap.zsh

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
znap source zsh-users/zsh-autosuggestions
znap source zdharma-continuum/fast-syntax-highlighting

# Load zsh-specific stuff
source ~/.config/zsh/setup
