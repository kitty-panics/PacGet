#!/bin/sh

#
# Environment variables (Modify) (Delete)
#

if [[ "$#" -ne 3 ]]; then
    echo Usage:
    echo EnvVarModDel.sh [user_type] [env_name] [env_value]
else
    user_type="$1"
    env_name="$2"
    env_value="$3"

    if [[ "$user_type" == "user" ]]; then
        reg_path_user="HKCU\Environment"
        env_value_exist=$(reg.exe query "$reg_path_user" /v "$env_name" | grep "$env_name" | awk '{print $3}')

        conv_env_value_exist=$(echo "$env_value_exist" | tr '\' '/')
        conv_env_value=$(echo "$env_value" | tr '\' '/')
        if [[ "$conv_env_value_exist"  =~ "$conv_env_value" ]]; then
            env_value_exist=$(echo "$conv_env_value_exist" | sed "s|$conv_env_value||" | tr '/' '\')
            setx.exe "$env_name" "$env_value_exist"
        else
            echo "\"$(basename $0)\" Info:"
            echo "Environment variable does not exists."
        fi
    elif [[ "$user_type" == "sys" ]]; then
        reg_path_sys="HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment"
        env_value_exist=$(reg.exe query "$reg_path_sys" /v "$env_name" | grep "$env_name" | awk '{print $3}')

        conv_env_value_exist=$(echo "$env_value_exist" | tr '\' '/')
        conv_env_value=$(echo "$env_value" | tr '\' '/')
        if [[ "$conv_env_value_exist"  =~ "$conv_env_value" ]]; then
            env_value_exist=$(echo "$conv_env_value_exist" | sed "s|;$conv_env_value||" | tr '/' '\')
            setx.exe "$env_name" "$env_value_exist" /m
        else
            echo "\"$(basename $0)\" Info:"
            echo "Environment variable does not exists."
        fi
    else
        echo "\"$(basename $0)\" Error:"
        echo "Unknown argument [user_type]."
    fi
fi
