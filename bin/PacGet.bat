@echo off
fltmc >nul 2>&1 || start "" mshta VBScript:CreateObject("Shell.Application").ShellExecute("cmd","/c pushd ""%~dp0"" && ""%~s0""","","runas",1)(window.close) && exit

::
:: PacGet
::

if defined KP_PACGET_DIR (
    set "_pacget=%KP_PACGET_DIR%"
) else (
    set "_pacget=.."
)
set "_pg_ext=%_pacget%\ext"

:: 
"%_pg_ext%"\busybox.exe sh PacGet.sh
