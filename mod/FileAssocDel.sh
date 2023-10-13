#!/bin/sh

#
# File association (Del)
#

if [[ "$#" -ne 1 ]]; then
    echo Usage:
    echo FileAssocDel.sh [file_type]
else
    file_type="$1"

    for i in `echo "$1" | tr ' ' '\n'`; do
        cmd.exe /c assoc ".$i"=
        cmd.exe /c ftype "kp.file.assoc.$i"=
    done
fi
