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

@echo off
echo Installing Git pre-commit hook...

REM Ensure we're in a Git repo
if not exist ".git" (
    echo ERROR: .git folder not found. Run this from the repo root.
    pause
    exit /b 1
)

REM Create hooks folder if missing
if not exist ".git\hooks" (
    mkdir ".git\hooks"
)

REM Remove any old/broken hook variants
if exist ".git\hooks\pre-commit.bat" del ".git\hooks\pre-commit.bat"

REM Install/overwrite the actual hook (Git expects the name 'pre-commit' with no extension)
copy /Y "scripts\pre-commit.hook" ".git\hooks\pre-commit" >nul

echo Git pre-commit hook installed successfully.

echo.
echo Done.
pause