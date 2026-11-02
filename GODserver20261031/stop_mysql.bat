@echo off
title Stop GOD MySQL Database
color 0C

set MYSQL_PORT=3306

cd /d "D:\000GOD"

echo ========================================================
echo             Stopping GOD MySQL Database
echo ========================================================
echo.

echo [*] Terminating mysqld.exe process...
taskkill /F /T /IM mysqld.exe >nul 2>&1

echo [*] Checking and freeing Port %MYSQL_PORT%...
for /f "tokens=5" %%a in ('netstat -ano ^| findstr /R /C:":%MYSQL_PORT% .*LISTENING"') do (
    if not "%%a"=="0" (
        echo [*] Force killing process on Port %MYSQL_PORT% (PID: %%a)...
        taskkill /F /PID %%a >nul 2>&1
    )
)

echo [*] Removing stale PID lock files...
del /F /Q "D:\GODserver\phpstudy_pro\Extensions\MySQL5.7.26\data\*.pid" >nul 2>&1

:: Verify port is freed
ping 127.0.0.1 -n 2 >nul
netstat -ano | findstr /R /C:":%MYSQL_PORT% .*LISTENING" >nul
if %errorlevel% == 0 (
    echo.
    echo [WARNING] Port %MYSQL_PORT% is still held by another process!
) else (
    echo.
    echo ========================================================
    echo [SUCCESS] MySQL Database stopped and Port %MYSQL_PORT% is FREE!
    echo ========================================================
)

echo.
pause