autoload -U colors && colors	   # Load colors

stty stop undef		               # Disable ctrl-s to freeze terminal.
zle_highlight=('paste:none')       # disable highlighting pasted text

# setopt correct
unsetopt flowcontrol
setopt interactive_comments

ZLE_REMOVE_SUFFIX_CHARS=$' \t\n;&' # more details can view through man zshparam
