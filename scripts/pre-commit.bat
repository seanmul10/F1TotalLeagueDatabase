@echo off
REM Auto-regenerate DB SQL dump before each commit

REM Dump the DB to SQL (adjust path if F1TOTAL.db isn't in repo root)
tools\sqlite3.exe F1TOTAL.db .dump > F1TOTAL_dump.sql

REM Stage the dump so it’s included in the commit
git add F1TOTAL_dump.sql

REM Always succeed (or add checks here if you want to block the commit on failure)
exit /b 0