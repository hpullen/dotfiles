# If in tmux, detach rather than exit
function exit {
    if [[ -z $TMUX ]]; then
        builtin exit
    else
        tmux detach
    fi
}

