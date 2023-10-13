#!/bin/sh

#
# Uninstall application
#

if [[ "$#" -ne 1 ]]; then
    echo Usage:
    echo AppUnin.sh [app_inst_path]
else
    app_inst_path="$1"

    cmd.exe /c rd /s /q "$app_inst_path"
fi
