#!/bin/sh

#
# File association (Add)
#

if [[ "$#" -ne 2 ]]; then
    echo Usage:
    echo FileAssocAdd.sh [file_type] [exe_path]
else
    file_type="$1"
    exe_path="$2"

    for i in `echo "$1" | tr ' ' '\n'`; do
        cmd.exe /c assoc ".$i"="kp.file.assoc.$i"
        cmd.exe /c ftype "kp.file.assoc.$i"="$exe_path" "%1"
    done
fi
