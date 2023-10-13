#!/bin/sh

#
# Kill .exe processes
#

if [[ "$#" -ne 1 ]]; then
    echo Usage:
    echo KillExe.sh [app_inst_path]
else
    app_inst_path=$(echo "$1" | tr '\' '/')

    for i in `find "$app_inst_path" -name *.exe`; do
        taskkill.exe /f /t /im $(basename "$i")
    done
fi
