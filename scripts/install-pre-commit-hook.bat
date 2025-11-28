@echo off
setlocal

REM This script lives in /scripts; repo root is one level up
set "SCRIPT_DIR=%~dp0"
set "ROOT_DIR=%SCRIPT_DIR%.."

cd /d "%ROOT_DIR%"

REM Ensure we're in a Git repo
if not exist ".git" (
    echo ERROR: .git folder not found. Run setup from the repo root.
    endlocal & exit /b 1
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

endlocal & exit /b 0