@echo off
fltmc >nul 2>&1 || start "" mshta VBScript:CreateObject("Shell.Application").ShellExecute("cmd","/c pushd ""%~dp0"" && ""%~s0""","","runas",1)(window.close) && exit

::
:: PKG - Lua54
::
:: Link:
:: https://luabinaries.sourceforge.net/download.html
::

:: App info
set "app_name=Lua54"
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

    :: Extra configuration
    cmd.exe /c copy "%app_inst_path%"\lua54.exe  "%app_inst_path%"\lua.exe
    cmd.exe /c copy "%app_inst_path%"\luac54.exe "%app_inst_path%"\luac.exe
    cmd.exe /c copy "%app_inst_path%"\wlua54.exe "%app_inst_path%"\wlua.exe
GOTO:EOF

:Execute_Uninstall
    "%_pg_ext%"\busybox.exe sh "%_pg_mod%"\KillExe.sh "%app_inst_path%"
    "%_pg_ext%"\busybox.exe sh "%_pg_mod%"\AppUnin.sh "%app_inst_path%"
    "%_pg_ext%"\busybox.exe sh "%_pg_mod%"\EnvVarModDel.sh "user" "Path" "%app_inst_path%"
GOTO:EOF
