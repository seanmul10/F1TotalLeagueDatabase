@echo off
setlocal

REM -----------------------------------------------------------------
REM  Paths
REM -----------------------------------------------------------------

REM DB relative to this script
set "DB=..\f1total.db"

REM Output for per-table data
set "OUTDIR=..\database\data"

REM Schema output (tracked in Git)
set "SCHEMA=..\database\schema.sql"

REM Whitelist of REAL state tables to dump
set "TABLES=__EFMigrationsHistory CarClasses Cars Championships Drivers DriverSessions Events Games Images LeagueCategories LeagueRoles LeagueSettings LineUps Nationalities PenaltyActions PenaltyItems PenaltyOffenses PenaltyPointsThresholds PenaltySystems PointActions Seasons SessionResults Teams Tracks Users Vendors"

echo ============================================================
echo   RACINGLEAGUETOOLS DATABASE DUMP
echo ============================================================
echo [INFO] Source DB : %DB%
echo [INFO] Schema    : %SCHEMA%
echo [INFO] Data out  : %OUTDIR%
echo.

if not exist "%DB%" (
    echo [ERROR] DB file not found: %DB%
    goto end
)

if not exist "%OUTDIR%" mkdir "%OUTDIR%"

REM -----------------------------------------------------------------
REM  STEP 1: Dump schema (exclude sqlite_sequence)
REM -----------------------------------------------------------------

echo [STEP 1] Dumping schema...
sqlite3 "%DB%" ".schema" | findstr /V /C:"sqlite_sequence" > "%SCHEMA%"
if errorlevel 1 (
    echo [ERROR] sqlite3 failed while dumping schema.
    goto end
)

if not exist "%SCHEMA%" (
    echo [ERROR] Schema file missing after dump.
    goto end
)

echo [OK] Schema dumped to %SCHEMA%
echo.

REM -----------------------------------------------------------------
REM  STEP 2: Dump data per whitelisted table
REM -----------------------------------------------------------------

echo [STEP 2] Dumping table data...

for %%T in (%TABLES%) do (
    echo [INFO] Dumping %%T...

    REM Start each file by wiping the table
    >"%OUTDIR%\%%T.sql" echo DELETE FROM "%%T";

    REM Dump rows as INSERTs for that specific table
    sqlite3 "%DB%" ".mode insert %%T" ".once %OUTDIR%\%%T.tmp" "SELECT * FROM %%T;"

    REM Append INSERTs to the file and delete temp
    type "%OUTDIR%\%%T.tmp" >> "%OUTDIR%\%%T.sql"
    del "%OUTDIR%\%%T.tmp"
)

echo.
echo [OK] Dump complete: schema + table data.
echo ============================================================

:end
echo.
endlocal
