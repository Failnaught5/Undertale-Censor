@echo off
setlocal
title Male Alphys Mod Installer

set "PATCH=Male-Alphys-v1.0.xdelta"
set "XDELTA=xdelta3.exe"
set "GAMEFILE=data.win"
set "BACKUP=data.win.backup"
set "TEMP=data_patched.win"

echo ==========================================
echo       MALE ALPHYS MOD INSTALLER
echo ==========================================
echo.

rem Make sure all required files are present.
if not exist "%XDELTA%" (
    echo ERROR: %XDELTA% was not found.
    echo Put this installer in the same folder as xdelta3.exe.
    echo.
    pause
    exit /b 1
)

if not exist "%PATCH%" (
    echo ERROR: %PATCH% was not found.
    echo Put this installer in the same folder as the .xdelta patch.
    echo.
    pause
    exit /b 1
)

if not exist "%GAMEFILE%" (
    echo ERROR: %GAMEFILE% was not found.
    echo.
    echo Put these files directly in the UNDERTALE game folder:
    echo   %XDELTA%
    echo   %PATCH%
    echo   INSTALL_MALE_ALPHYS.bat
    echo.
    echo Then run this installer again.
    echo.
    pause
    exit /b 1
)

rem Preserve the original game file the first time the installer is run.
if not exist "%BACKUP%" (
    echo Creating backup...
    copy /Y "%GAMEFILE%" "%BACKUP%" >nul
    if errorlevel 1 (
        echo ERROR: Could not create %BACKUP%.
        echo Try running the installer again with permission to write to this folder.
        echo.
        pause
        exit /b 1
    )
    echo Backup created: %BACKUP%
) else (
    echo Existing backup found: %BACKUP%
    echo The installer will use that backup as the clean source.
)

echo.
echo Applying patch...
if exist "%TEMP%" del /Q "%TEMP%" >nul 2>&1

"%XDELTA%" -d -s "%BACKUP%" "%PATCH%" "%TEMP%"
if errorlevel 1 (
    echo.
    echo ==========================================
    echo PATCH FAILED
    echo ==========================================
    echo.
    echo Your current data.win was NOT replaced.
    echo Your backup is still safe as %BACKUP%.
    echo.
    echo Common causes:
    echo - The backup is from a different UNDERTALE version.
    echo - The backup was already modded before this installer was first run.
    echo - The patch file is incomplete or corrupted.
    echo.
    if exist "%TEMP%" del /Q "%TEMP%" >nul 2>&1
    pause
    exit /b 1
)

echo Patch created successfully.
echo Replacing data.win...

move /Y "%TEMP%" "%GAMEFILE%" >nul
if errorlevel 1 (
    echo.
    echo ERROR: The patch was created, but data.win could not be replaced.
    echo Your original backup is still safe as %BACKUP%.
    echo.
    pause
    exit /b 1
)

echo.
echo ==========================================
echo INSTALLATION COMPLETE
echo ==========================================
echo.
echo Male Alphys has been installed.
echo Original backup: %BACKUP%
echo.
echo You can now launch UNDERTALE normally.
echo.
pause
exit /b 0
