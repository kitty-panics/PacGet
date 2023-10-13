#!/bin/sh

#
# Environment variables (Modify)
#

if [[ "$#" -ne 4 ]]; then
    echo Usage:
    echo EnvVarMod.sh [user_type] [ins_posi] [env_name] [env_value]
else
    user_type="$1"
    ins_posi="$2"
    env_name="$3"
    env_value="$4"

    if [[ "$user_type" == "user" ]]; then
        reg_path_user="HKCU\Environment"
        env_value_exist=$(reg.exe query "$reg_path_user" /v "$env_name" | grep "$env_name" | awk '{print $3}')
        if [[ $(echo "$env_value_exist" | tr '\' '/') =~ $(echo "$env_value" | tr '\' '/') ]]; then
            echo "\"$(basename $0)\" Info:"
            echo "Environment variable already exists."
        else
            if [[ "$ins_posi" == "head" ]]; then
                setx.exe "$env_name" "$env_value;$env_value_exist"
            elif [[ "$ins_posi" == "tail" ]]; then
                setx.exe "$env_name" "$env_value_exist;$env_value"
            else
                echo "\"$(basename $0)\" Error:"
                echo "Unknown argument [ins_posi]."
            fi
        fi
    elif [[ "$user_type" == "sys" ]]; then
        reg_path_sys="HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment"
        env_value_exist=$(reg.exe query "$reg_path_sys" /v "$env_name" | grep "$env_name" | awk '{print $3}')
        if [[ $(echo "$env_value_exist" | tr '\' '/') =~ $(echo "$env_value" | tr '\' '/') ]]; then
            echo "\"$(basename $0)\" Info:"
            echo "Environment variable already exists."
        else
            if [[ "$ins_posi" == "head" ]]; then
                setx.exe "$env_name" "$env_value;$env_value_exist" /m
            elif [[ "$ins_posi" == "tail" ]]; then
                setx.exe "$env_name" "$env_value_exist;$env_value" /m
            else
                echo "\"$(basename $0)\" Error:"
                echo "Unknown argument [ins_posi]."
            fi
        fi
    else
        echo "\"$(basename $0)\" Error:"
        echo "Unknown argument [user_type]."
    fi
fi
