@echo off
setlocal ENABLEDELAYEDEXPANSION

REM This script lives in:   repo\scripts\force-unlock.bat
REM We need to step up to:  repo\
cd /d "%~dp0\.."

echo ============================================
echo   Git LFS FORCE UNLOCK
echo ============================================
echo.

echo Currently locked files:
git lfs locks
echo.

set "FILE="
set /P FILE=Enter the file to force-unlock (exact path shown above, blank to cancel): 

if "%FILE%"=="" (
    echo.
    echo No file entered. Aborted.
    goto :eof
)

echo.
echo You are about to FORCE UNLOCK:
echo   "%FILE%"
echo.

echo Current lock info for this file (if any):
git lfs locks --path="%FILE%"
echo.

echo This will break the lock even if someone else owns it,
echo and any unmerged work they have on this file may be LOST.
echo.

set "CONFIRM="
set /P CONFIRM=Type YES to continue, or anything else to cancel: 

if /I not "%CONFIRM%"=="YES" (
    echo.
    echo Aborted, lock not changed.
    goto :eof
)

echo.
echo Attempting force unlock...
git lfs unlock --force "%FILE%"
if errorlevel 1 (
    echo.
    echo Failed to force unlock. See error above.
    goto :eof
)

echo.
echo Force unlock complete.
echo.

endlocal
pause
