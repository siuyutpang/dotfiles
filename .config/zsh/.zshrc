# Sy's config for the Zoomer Shell

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d "$ZINIT_HOME/.git" ] && mkdir -p "$(dirname "$ZINIT_HOME")" && \
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"

declare -A ZINIT
ZINIT[ZCOMPDUMP_PATH]="${XDG_CACHE_HOME:-${HOME}/.cache}/zsh/zcompdump-$ZSH_VERSION"
# Leave zi available for zoxide.
ZINIT[NO_ALIASES]=1
source "$ZINIT_HOME/zinit.zsh"

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
zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode

zinit ice wait lucid atload'_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

zinit ice wait lucid blockf atpull'zinit creinstall -q .'
zinit light zsh-users/zsh-completions

zinit ice wait'0b' lucid
zinit light zdharma-continuum/fast-syntax-highlighting

zinit ice id-as'zinit/compinit' lucid as'null' wait'0c' \
    atload'zicompinit; zicdreplay'
zinit light zdharma-continuum/null

# Load zsh-specific stuff
source ~/.config/zsh/setup
