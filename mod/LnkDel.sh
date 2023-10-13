#!/bin/sh

#
# Delete desktop shortcut
#

if [[ "$#" -ne 1 ]]; then
    echo Usage:
    echo LnkDel.sh [link_file]
else
    link_file="$1"

    cmd.exe /c del /f /q "$link_file"
fi
