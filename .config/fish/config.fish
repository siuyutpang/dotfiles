fish_vi_key_bindings

set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore
set fish_cursor_visual block

function fish_mode_prompt
end

if status is-interactive
    # Commands to run in interactive sessions can go here
    set -g fish_greeting
end
