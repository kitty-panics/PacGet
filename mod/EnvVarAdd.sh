#!/bin/sh

#
# Environment variables (Add)
#

if [[ "$#" -ne 3 ]]; then
    echo Usage:
    echo EnvVarAdd.sh [user_type] [env_name] [env_value]
else
    user_type="$1"
    env_name="$2"
    env_value="$3"

    if [[ "$user_type" == "user" ]]; then
        setx.exe "$env_name" "$env_value"
    elif [[ "$user_type" == "sys" ]]; then
        setx.exe "$env_name" "$env_value" /m
    else
        echo "\"$(basename $0)\" Error:"
        echo "Unknown argument [user_type]."
    fi
fi
