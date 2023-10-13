#!/bin/sh

#
# Add Desktop shortcut
#

if [[ "$#" -lt 2 ]]; then
    echo Usage:
    echo LnkAdd.sh [target_path] [lnk_file] [options]
    exit
fi

target_path="$1" # 目标
lnk_file="$2"   # .lnk 位置

while [[ "$#" -gt 0 ]]; do
    case "$3" in
        "-a" | "--Arguments") # 参数，追加到 target_path 后面。使用 %% 表示 %
            arguments="$4"
            line_arguments="\$cs.Arguments = \"$arguments\";"
            shift
            ;;
        "-d" | "--Description") # 备注
            description="$4"
            line_description="\$cs.Description = \"$description\";"
            shift
            ;;
        "-fn" | "--FullName")
            full_name="$4"
            line_full_name="\$cs.FullName = \"$full_name\";"
            shift
            ;;
        "-h" | "--Hotkey") # 快捷键
            hotkey="$4"
            line_hotkey="\$cs.Hotkey = \"$hotkey\";"
            shift
            ;;
        "-il" | "--IconLocation") # 图标
            icon_location="$4"
            line_icon_location="\$cs.IconLocation = \"$icon_location\";"
            shift
            ;;
        "-rp" | "--RelativePath")
            relative_path="$4"
            line_relative_path="\$cs.RelativePath = \"$relative_path\";"
            shift
            ;;
        "-ws" | "--WindowStyle") # 运行方式。1=常规窗口；3=最大化；7=最小化
            window_style="$4"
            line_window_style="\$cs.WindowStyle = $window_style;"
            shift
            ;;
        "-wd" | "--WorkingDirectory") # 起始位置
            working_directory="$4"
            line_working_directory="\$cs.WorkingDirectory = \"$working_directory\";"
            shift
            ;;
        *)
            shift
            ;;
    esac
done

powershell.exe -ExecutionPolicy Bypass -NoLogo -NonInteractive -NoProfile "\$wss = New-Object -ComObject WScript.Shell; \$cs = \$wss.CreateShortcut(\"$lnk_file\"); $line_arguments $line_description $line_full_name $line_hotkey $line_icon_location $line_relative_path \$cs.TargetPath = \"$target_path\"; $line_window_style $line_working_directory \$cs.Save();"

# \$wss = New-Object -ComObject WScript.Shell;
# \$cs = \$wss.CreateShortcut(\"$lnk_file\");
# $line_arguments
# $line_description
# $line_full_name
# $line_hotkey
# $line_icon_location
# $line_relative_path
# \$cs.TargetPath = \"$target_path\";
# $line_window_style
# $line_working_directory
# \$cs.Save();"

# echo Target_Path      : $target_path
# echo Lnk_file         : $lnk_file
# echo Arguments        : $arguments
# echo Description      : $description
# echo Full_Name        : $full_name
# echo Hotkey           : $hotkey
# echo Icon_Location    : $icon_location
# echo Relative_Path    : $relative_path
# echo Window_Style     : $window_style
# echo Working_Directory: $working_directory
# echo "\$wss = New-Object -ComObject WScript.Shell; \$cs = \$wss.CreateShortcut(\"$lnk_file\"); $line_arguments $line_description $line_full_name $line_hotkey $line_icon_location $line_relative_path \$cs.TargetPath = \"$target_path\"; $line_window_style $line_working_directory \$cs.Save();"
