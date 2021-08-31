#!/bin/bash

while [ "$#" -gt 0 ]; do
    curr=$1
    shift

    case "$curr" in
    "-mc")
        tmux new -s mycookbook -d
        tmux neww -t mycookbook: -n watch -d 'cd ~/work/mycookbook.git/master && npm run watch'
        tmux neww -t mycookbook: -n server -d 'cd ~/work/mycookbook.git/master && npm run server'
        ;;
    *) echo "Unavailable command... $curr"
    esac
done
