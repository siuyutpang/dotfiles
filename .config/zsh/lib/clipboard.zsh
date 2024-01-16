# - pbcopy, pbpaste (macOS)
# - wl-copy, wl-paste (wayland)
# - xclip/xsel (X11)

function detect-clipboard() {
    emulate -L zsh

    if [[ "${OSTYPE}" == darwin* ]] && (( ${+commands[pbcopy]} )) && (( ${+commands[pbpaste]} )); then
        function clipcopy() { cat "${1:-/dev/stdin}" | pbcopy; }
        function clippaste() { pbpaste; }
    elif [ -n "${WAYLAND_DISPLAY:-}" ] && (( ${+commands[wl-copy]} )) && (( ${+commands[wl-paste]} )); then
        function clipcopy() { cat "${1:-/dev/stdin}" | wl-copy &>/dev/null &|; }
        function clippaste() { wl-paste -n; }
    elif [ -n "${DISPLAY:-}" ] && (( ${+commands[xclip]} )); then
        function clipcopy() { cat "${1:-/dev/stdin}" | xclip -sel clip &>/dev/null &|; }
        function clippaste() { xclip -o -sel clip; }
    elif [ -n "${DISPLAY:-}" ] && (( ${+commands[xsel]} )); then
        function clipcopy() { cat "${1:-/dev/stdin}" | xsel -ib; }
        function clippaste() { xsel -ob; }
    else
        return 1
    fi
}

function clipcopy clippaste {
  unfunction clipcopy clippaste
  detect-clipboard
  "$0" "$@"
}
