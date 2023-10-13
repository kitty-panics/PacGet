#!/bin/sh

#
# Delete "Open with XYZ" to the right-click menu
#

if [[ "$#" -ne 1 ]]; then
    echo Usage:
    echo OpenWithDel.sh [app_name]
else
    app_name="$1"

    reg_path="HKCR\*\shell\Open with $app_name"
    reg.exe delete "$reg_path" /f
fi
