@echo off
setlocal
title Male Alphys Mod Uninstaller

set "GAMEFILE=data.win"
set "BACKUP=data.win.backup"

echo ==========================================
echo      MALE ALPHYS MOD UNINSTALLER
echo ==========================================
echo.

if not exist "%BACKUP%" (
    echo ERROR: %BACKUP% was not found.
    echo There is no automatic backup to restore.
    echo.
    pause
    exit /b 1
)

echo Restoring original data.win...
copy /Y "%BACKUP%" "%GAMEFILE%" >nul

if errorlevel 1 (
    echo.
    echo ERROR: Could not restore the backup.
    echo.
    pause
    exit /b 1
)

echo.
echo ==========================================
echo RESTORE COMPLETE
echo ==========================================
echo.
echo The original data.win has been restored.
echo The backup file was kept in case you need it again.
echo.
pause
exit /b 0
