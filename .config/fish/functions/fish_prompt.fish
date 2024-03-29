# reference magicmace theme
function fish_prompt
    set -l last_status $status
    if test $last_status != 0
        set_color green --bold
        printf "─"
        set_color red --bold
        printf "%s" $last_status
        set_color green --bold
        printf "─"
    end
    set_color green --bold
    printf "["
    set_color white
    printf "%s" (prompt_pwd)
    set_color green --bold
    printf "]"
    printf "── ─ "
    set_color normal
end
