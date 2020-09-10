#!/usr/bin/env bash
exec 2>&1
which fswatch
if [[ "$?" -ne "0" ]]; then
    echo "fswatch is not found or not installed "
    echo "Do you want to install fswatch? y/[n]:"
    read -n 1 -s char 
    echo "$char"
    if [[ "$char" = "y" ]]; then
        # brew install fswatch
        echo "install fswatch"
    else
        echo "I cannot continue, sorry..."
        exit 1
    fi 
fi




