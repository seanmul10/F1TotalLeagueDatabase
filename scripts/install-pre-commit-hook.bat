@echo off
setlocal

REM This script lives in /scripts; repo root is one level up
set "SCRIPT_DIR=%~dp0"
set "ROOT_DIR=%SCRIPT_DIR%.."

cd /d "%ROOT_DIR%"

REM Ensure we're in a Git repo
if not exist ".git" (
    echo ERROR: .git folder not found. Run setup from inside a cloned repo.
    endlocal & exit /b 1
)

echo ================================
echo   Repository setup
echo ================================
echo.

REM Ensure Git LFS is installed/configured
echo Installing / configuring Git LFS...
git lfs install
if errorlevel 1 (
    echo ERROR: git lfs install failed. Make sure Git LFS is installed on this machine.
    endlocal & exit /b 1
)
echo Git LFS ready.
echo.

REM Create hooks folder if missing
if not exist ".git\hooks" (
    mkdir ".git\hooks"
)

REM Remove any old/broken hook variants
if exist ".git\hooks\pre-commit" del ".git\hooks\pre-commit"
if exist ".git\hooks\pre-commit.bat" del ".git\hooks\pre-commit.bat"

REM Install/overwrite the actual hook (Git expects the name 'pre-commit')
copy /Y "scripts\pre-commit.hook" ".git\hooks\pre-commit" >nul
if errorlevel 1 (
    echo ERROR: Failed to copy scripts\pre-commit.hook to .git\hooks\pre-commit
    endlocal & exit /b 1
)

REM Try to make it executable for Bash users (safe to ignore failures)
bash -c "chmod +x .git/hooks/pre-commit" 2>nul

echo Git pre-commit hook installed successfully.
echo Setup complete.

endlocal & exit /b 0
