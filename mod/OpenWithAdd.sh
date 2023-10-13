#!/bin/sh

#
# Add "Open with XYZ" to the right-click menu
#

if [[ "$#" -ne 3 ]]; then
    echo Usage:
    echo OpenWithAdd.sh [app_name] [exe_path] [ico_path]
else
    app_name="$1"
    exe_path="$2"
    ico_path="$3"

    reg_path="HKCR\*\shell\Open with $app_name"
    reg.exe add "$reg_path"           /t REG_SZ /d "Open with $app_name" /f
    reg.exe add "$reg_path\command"   /t REG_SZ /d "$exe_path %1"        /f
    reg.exe add "$reg_path" /v "Icon" /t REG_SZ /d "$ico_path"           /f
fi
