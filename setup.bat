@echo off
setlocal enabledelayedexpansion

:ask
echo Enter the base path of your RacingLeagueTools app installation: (eg. C:\Users\me\Downloads\RacingLeagueTools):
set /p BASE=

REM Normalise quotes removed if the user pasted them
set BASE=%BASE:"=%

REM Validate the exe exists
if not exist "%BASE%\RacingLeagueTools.exe" (
    echo.
    echo ERROR: "%BASE%\RacingLeagueTools.exe" was not found.
    echo Please enter the folder that contains RacingLeagueTools.exe.
    echo.
    goto ask
)

REM Build full target path
set TARGET=%BASE%\user\themes

REM Resolve the repo's themes folder
set SOURCE=%~dp0themes

echo.
echo Creating symlink:
echo   Source: %SOURCE%
echo   Target: %TARGET%
echo.

REM Create intermediate folder if needed
if not exist "%BASE%\user" mkdir "%BASE%\user"

REM Remove existing directory or junction if present
if exist "%TARGET%" rmdir "%TARGET%" /S /Q

REM Create the directory junction
mklink /J "%TARGET%" "%SOURCE%"

echo.
echo Done.
pause