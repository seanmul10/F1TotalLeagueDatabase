@echo off

REM Location of this script and the config file
set "SCRIPT_DIR=%~dp0"
set "CONFIG_FILE=%SCRIPT_DIR%app_path.txt"
set "BASE="

REM Try to read saved path if it exists
if exist "%CONFIG_FILE%" (
    for /f "usebackq tokens=* delims=" %%A in ("%CONFIG_FILE%") do (
        set "BASE=%%A"
        goto have_base_candidate
    )
)

goto ask

:have_base_candidate
REM Strip any stray quotes
set "BASE=%BASE:"=%"

echo Found saved RacingLeagueTools path in app_path.txt:
echo   %BASE%

if exist "%BASE%\RacingLeagueTools.exe" (
    goto have_base
) else (
    echo Saved path is invalid, will ask for a new one...
    echo.
    set "BASE="
    goto ask
)

:ask
echo Enter the base path of your RacingLeagueTools app installation:
echo   (eg. C:\Users\me\Downloads\RacingLeagueTools)
set /p BASE=

REM Strip quotes if they pasted a quoted path
set "BASE=%BASE:"=%"

REM Validate the exe exists
if not exist "%BASE%\RacingLeagueTools.exe" (
    echo.
    echo ERROR: "%BASE%\RacingLeagueTools.exe" was not found.
    echo Please enter the folder that contains RacingLeagueTools.exe.
    echo.
    goto ask
)

REM Save the valid path for next time
> "%CONFIG_FILE%" echo %BASE%

:have_base
REM Build full target path
set "TARGET=%BASE%\user\themes"

REM Resolve the repo's themes folder
set "SOURCE=%SCRIPT_DIR%themes"

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
if exist ".git\hooks\pre-commit" del ".git\hooks\pre-commit"
if exist ".git\hooks\pre-commit.bat" del ".git\hooks\pre-commit.bat"

REM Install/overwrite the actual hook (Git expects the name 'pre-commit')
copy /Y "scripts\pre-commit.hook" ".git\hooks\pre-commit" >nul

echo Git pre-commit hook installed successfully.
echo.
echo Done.
pause