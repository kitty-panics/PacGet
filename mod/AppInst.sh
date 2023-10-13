#!/bin/sh

#
# Install application
#

if [[ "$#" -ne 2 ]]; then
    echo Usage:
    echo AppInst.sh [app_name] [app_file_name]
else
    _pacget="$(dirname $(pwd))"
    _pacget_ext="$_pacget/ext"
    _pacget_mod="$_pacget/mod"
    _pacget_repo="$_pacget/repo"

    app_name="$1"
    app_file_name="$2"
    app_inst_dir="$HOMEDRIVE\APP-Files"

    "$_pacget_ext"/7z.exe x -aos "$_pacget_repo/$app_file_name" -o"$app_inst_dir"
fi
