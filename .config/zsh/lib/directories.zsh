# Changing/making/removing directory
setopt auto_cd
setopt auto_pushd
setopt pushd_silent
setopt pushd_ignore_dups
setopt pushdminus

alias -- -='cd -'

for index in {1..9}; do
    alias "$index"="cd -${index}"
done
unset index

function d () {
  if [[ -n $1 ]]; then
    dirs "$@"
  else
    dirs -v | head -n 10
  fi
}
compdef _dirs d
