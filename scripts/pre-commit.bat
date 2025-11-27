@echo off
REM Pre-commit: dump F1TOTAL.db to F1TOTAL_dump.sql and stage it

setlocal

REM Go to repo root (scripts\..)
set SCRIPT_DIR=%~dp0
cd /d "%SCRIPT_DIR%\.."

REM Sanity checks
if not exist "tools\sqlite3.exe" (
    echo [pre-commit] ERROR: tools\sqlite3.exe not found in tools\.
    exit /b 1
)

if not exist "F1TOTAL.db" (
    echo [pre-commit] ERROR: F1TOTAL.db not found in repo root.
    exit /b 1
)

REM Generate dump
tools\sqlite3.exe F1TOTAL.db .dump > F1TOTAL_dump.sql
if errorlevel 1 (
    echo [pre-commit] ERROR: sqlite3 dump failed.
    exit /b 1
)

REM Stage the dump so it’s included in this commit
git add F1TOTAL_dump.sql

endlocal
exit /b 0