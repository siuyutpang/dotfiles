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
                *.tar)              tar -xvf "$file" --one-top-level ;;
                *.txz|*.tar.xz)     tar --xz    -xvf "$file" --one-top-level ;;
                *.tgz|*.tar.gz)     tar --gzip  -xvf "$file" --one-top-level ;;
                *.tbz2|*.tar.bz2)   tar --bzip2 -xvf "$file" --one-top-level ;;
                *.tzst|*.tar.zst)   tar --zstd  -xvf "$file" --one-top-level ;;
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
                                    builtin cd control; tar -xvf ../control.tar.*
                                    builtin cd ../data; tar -xvf ../data.tar.*
                                    builtin cd ..; command rm *.tar.* debian-binary ;;
                *)                  echo "'$file': unrecognized file compression." ;;
            esac
        else
            echo "'$file' is not a valid file."
        fi
    done
}
