@echo off
setlocal
set "SCRIPT_DIR=%~dp0"

echo Running RacingLeagueTools themes setup...
call "%SCRIPT_DIR%scripts\configure-rlt-links.bat"
if errorlevel 1 (
    echo.
    echo ERROR: configure-rlt-links.bat failed.
    pause
    endlocal & exit /b 1
)

echo.
echo Installing Git pre-commit hook...
call "%SCRIPT_DIR%scripts\install-pre-commit-hook.bat"
if errorlevel 1 (
    echo.
    echo ERROR: install-pre-commit-hook.bat failed.
    pause
    endlocal & exit /b 1
)

echo.
echo All setup steps completed successfully.
pause
endlocal & exit /b 0