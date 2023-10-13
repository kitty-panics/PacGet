#!/bin/sh

#
# Environment variables (Add) (Delete)
#

if [[ "$#" -ne 2 ]]; then
    echo Usage:
    echo EnvVarAddDel.sh [user_type] [env_name]
else
    user_type="$1"
    env_name="$2"

    if [[ "$user_type" == "user" ]]; then
        setx.exe "$env_name" ""
        reg.exe delete "HKCU\Environment" /v "$env_name" /f
    elif [[ "$user_type" == "sys" ]]; then
        setx.exe "$env_name" "" /m
        reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v "$env_name" /f
    else
        echo "\"$(basename $0)\" Error:"
        echo "Unknown argument [user_type]."
    fi
fi
