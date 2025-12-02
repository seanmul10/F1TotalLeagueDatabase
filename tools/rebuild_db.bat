@echo off
setlocal ENABLEDELAYEDEXPANSION

set "RC=0"

echo ============================================================
echo   RACINGLEAGUETOOLS DATABASE REBUILD (SAFE MODE)
echo ============================================================
echo.

REM ------------------------------------------------------------
REM  Paths
REM ------------------------------------------------------------

set "DB=..\f1total.db"
set "TEMP_DB=..\f1total_temp.db"
set "SCHEMA=..\database\schema.sql"
set "DATADIR=..\database\data"

echo [INFO] Target DB (will be replaced): %DB%
echo [INFO] Temporary DB: %TEMP_DB%
echo [INFO] Schema file (tracked): %SCHEMA%
echo [INFO] Data folder: %DATADIR%
echo.

REM ------------------------------------------------------------
REM  STEP 1: Verify schema + data files exist
REM ------------------------------------------------------------

echo [STEP 1] Verifying schema and data...

if not exist "%SCHEMA%" (
    echo [ERROR] Schema file not found: %SCHEMA%
    echo [HINT] This file should be tracked in Git.
    set "RC=1"
    goto end
)

if not exist "%DATADIR%" (
    echo [ERROR] Data folder not found: %DATADIR%
    echo [HINT] Run your dump script first to generate per-table .sql files.
    set "RC=1"
    goto end
)

REM Whitelist of tables – must match dump_db.bat
set "TABLES=__EFMigrationsHistory CarClasses Cars Championships Drivers DriverSessions Events Games Images LeagueCategories LeagueRoles LeagueSettings LineUps Nationalities PenaltyActions PenaltyItems PenaltyOffenses PenaltyPointsThresholds PenaltySystems PointActions Seasons SessionResults Teams Tracks Users Vendors"

echo [INFO] Tables expected for import:
for %%T in (%TABLES%) do echo        - %%T
echo.

REM ------------------------------------------------------------
REM  STEP 2: Create TEMP_DB and apply schema from Git (fast)
REM ------------------------------------------------------------

echo [STEP 2] Creating clean temporary rebuild DB...
if exist "%TEMP_DB%" (
    echo [INFO] Old temp DB exists, deleting...
    del "%TEMP_DB%"
)

REM Temp file to wrap schema in a single transaction + relaxed PRAGMAs
set "SCHEMA_IMPORT=..\database\schema_import.tmp.sql"

echo [INFO] Building transactional schema script: %SCHEMA_IMPORT%

> "%SCHEMA_IMPORT%" echo PRAGMA journal_mode=OFF;
>>"%SCHEMA_IMPORT%" echo PRAGMA synchronous=OFF;
>>"%SCHEMA_IMPORT%" echo PRAGMA foreign_keys=OFF;
>>"%SCHEMA_IMPORT%" echo BEGIN;

type "%SCHEMA%" >> "%SCHEMA_IMPORT%"

>>"%SCHEMA_IMPORT%" echo COMMIT;
>>"%SCHEMA_IMPORT%" echo PRAGMA foreign_keys=ON;

echo [INFO] Applying schema from %SCHEMA_IMPORT% to %TEMP_DB%...
sqlite3 "%TEMP_DB%" ".read %SCHEMA_IMPORT%"
if errorlevel 1 (
    echo [ERROR] Failed while applying schema to temporary DB.
    if exist "%TEMP_DB%" del "%TEMP_DB%"
    if exist "%SCHEMA_IMPORT%" del "%SCHEMA_IMPORT%"
    set "RC=1"
    goto end
)

del "%SCHEMA_IMPORT%"

echo [OK] Schema successfully applied to temporary DB.
echo.

REM ------------------------------------------------------------
REM  STEP 3: Import data for each table (transactional)
REM ------------------------------------------------------------

echo [STEP 3] Importing table data (transactional)...

for %%T in (%TABLES%) do (
    echo.
    echo -----------------------------------------------
    echo Processing table: %%T
    echo -----------------------------------------------

    set "TABLESQL=%DATADIR%\%%T.sql"

    if exist "!TABLESQL!" (
        set "TEMPFILE=%DATADIR%\%%T_import.tmp.sql"

        echo [INFO] Preparing transactional script: !TEMPFILE!

        > "!TEMPFILE!" echo BEGIN;
        type "!TABLESQL!" >> "!TEMPFILE!"
        >> "!TEMPFILE!" echo COMMIT;

        echo [INFO] Importing with transaction from !TEMPFILE! ...
        sqlite3 "%TEMP_DB%" ".read !TEMPFILE!"
        if errorlevel 1 (
            echo [ERROR] Failed importing table %%T
            del "!TEMPFILE!"
            set "RC=1"
            goto end
        )

        del "!TEMPFILE!"
        echo [OK] Imported %%T successfully.
    ) else (
        echo [WARNING] Dump not found for %%T. Skipping.
    )
)

echo.
echo [OK] All table imports completed.
echo.

REM ------------------------------------------------------------
REM  STEP 4: Replace original DB with TEMP_DB
REM ------------------------------------------------------------

echo [STEP 4] Replacing original DB...

if exist "%DB%" (
    echo [INFO] Deleting old DB: %DB%
    del "%DB%"
)

echo [INFO] Moving %TEMP_DB% -> %DB%
move "%TEMP_DB%" "%DB%" >nul

if errorlevel 1 (
    echo [ERROR] Could not replace original DB.
    echo [INFO] Temporary DB left at: %TEMP_DB%
    set "RC=1"
    goto end
)

echo [OK] Rebuild complete. New DB is
