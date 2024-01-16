alias x=extract

function extract() {
    if [ "$#" -eq 0 ]; then
        cat >&2 <<'EOF'
Usage: extract [file ...]
EOF
    return 1
    fi

    for file in "$@"; do
        if [ -f "$file" ]; then
            case "$file" in
                *.tar)              tar -xvf "$file" ;;
                *.txz|*.tar.xz)     tar -xvJf "$file" ;;
                *.tgz|*.tar.gz)     tar -xvzf "$file" ;;
                *.tbz2|*.tar.bz2)   tar -xvjf "$file" ;;
                *.tzst|*.tar.zst)   tar --zstd -xvf "$file" ;;
                *.xz)               unxz "$file" ;;
                *.gz)               gunzip "$file" ;;
                *.bz2)              bunzip2 "$file" ;;
                *.zst)              unzstd "$file" ;;
                *.rar)              unrar x "$file" ;;
                *.zip|*.jar|*.war)  unzip "$file" -d "${file%%.*}" ;;
                *.cpio)             cpio -idmvF "$file" ;;
                *.lzma)             unlzma "$file" ;;
                *.Z)                uncompress "$file" ;;
                *.deb)
                                    command mkdir -p "data" "control"
                                    ar x "$file" > /dev/null
                                    builtin cd control; extract ../control.tar.*
                                    builtin cd ../data; extract ../data.tar.*
                                    builtin cd ..; command rm *.tar.* debian-binary ;;
                *)                  echo "'$file': unrecognized file compression." ;;
            esac
        else
            echo "'$file' is not a valid file."
        fi
    done
}
