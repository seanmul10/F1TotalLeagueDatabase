@echo off
setlocal ENABLEDELAYEDEXPANSION

REM Usage: force-unlock.bat path\to\file.db

if "%~1"=="" (
    echo Usage: %~n0 path\to\file.db
    echo.
    echo Currently locked files:
    git lfs locks
    echo.
    goto :eof
)

set "FILE=%~1"

echo You are about to FORCE UNLOCK:
echo   %FILE%
echo.
echo Current lock info for this file (if any):
git lfs locks "%FILE%"
echo.
echo This will break the lock even if someone else owns it,
echo and any unmerged work they have on this file may be LOST.
echo.

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
endlocal