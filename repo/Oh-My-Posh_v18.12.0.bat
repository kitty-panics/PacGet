@echo off
fltmc >nul 2>&1 || start "" mshta VBScript:CreateObject("Shell.Application").ShellExecute("cmd","/c pushd ""%~dp0"" && ""%~s0""","","runas",1)(window.close) && exit

::
:: PKG - Oh-My-Posh
::
:: Link:
:: https://github.com/JanDeDobbeleer/oh-my-posh/releases
::

:: App info
set "app_name=Oh-My-Posh"
set "app_file_name=%~n0"
set "app_inst_dir=%HOMEDRIVE%\APP-Files"
set "app_inst_path=%app_inst_dir%\%app_name%"
set "desktop_dir=%USERPROFILE%\Desktop"

if defined KP_PACGET_DIR (
    set "_pacget=%KP_PACGET_DIR%"
) else (
    set "_pacget=.."
)

if "%~1" == "" (
    set "app_inst_acti=inst"
) else (
    set "app_inst_acti=%~1"
)
set "_pg_ext=%_pacget%\ext"
set "_pg_mod=%_pacget%\mod"

if "%app_inst_acti%" == "inst" (
    call:Execute_Install
) else if "%app_inst_acti%" == "rein" (
    call:Execute_Reinstall
) else if "%app_inst_acti%" == "unin" ( 
    call:Execute_Uninstall
) else (
    echo=
    echo #
    echo # "%~n0" InstScript:
    echo # Argument [app_inst_acti] Error.
    echo #
    echo=
)
GOTO:EOF

:Execute_Reinstall
    call:Execute_Uninstall
    call:Execute_Install
GOTO:EOF

:Execute_Install
    "%_pg_ext%"\busybox.exe sh "%_pg_mod%"\AppInst.sh "%app_name%" "%app_file_name%.7z"
    "%_pg_ext%"\busybox.exe sh "%_pg_mod%"\EnvVarMod.sh "user" "tail" "Path" "%app_inst_path%"

    call:Execute_Install_Conf
GOTO:EOF

:Execute_Install_Conf
        rem Oh-My-Posh
    set "_pg_app_conf_dir_ohmyposh=%USERPROFILE%\Documents\WindowsPowerShell"
    set "_pg_app_conf_file_ohmyposh=%_pg_app_conf_dir_ohmyposh%\Microsoft.PowerShell_profile.ps1"
    cmd.exe /c md "%_pg_app_conf_dir_ohmyposh%"
    cmd.exe /c echo | set /p = "oh-my-posh.exe init pwsh | Invoke-Expression" > "%_pg_app_conf_file_ohmyposh%"
        rem PowerShell
    powershell.exe "Set-ExecutionPolicy -ExecutionPolicy RemoteSigned"
GOTO:EOF

:Execute_Uninstall
    "%_pg_ext%"\busybox.exe sh "%_pg_mod%"\KillExe.sh "%app_inst_path%"
    call:Execute_Uninstall_Conf

    "%_pg_ext%"\busybox.exe sh "%_pg_mod%"\AppUnin.sh "%app_inst_path%"
    "%_pg_ext%"\busybox.exe sh "%_pg_mod%"\EnvVarModDel.sh "user" "Path" "%app_inst_path%"
GOTO:EOF

:Execute_Uninstall_Conf
        rem Oh-My-Posh
    set "_pg_app_conf_dir_ohmyposh=%USERPROFILE%\Documents\WindowsPowerShell"
    set "_pg_app_conf_file_ohmyposh=%_pg_app_conf_dir_ohmyposh%\Microsoft.PowerShell_profile.ps1"
    cmd.exe /c del /f /q "%_pg_app_conf_file_ohmyposh%"
        rem PowerShell
    powershell.exe "Set-ExecutionPolicy -ExecutionPolicy Undefined"
GOTO:EOF
