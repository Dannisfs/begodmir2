@echo off
title GOD MySQL Database Controller
color 0E

:: ========================================================
:: [CONFIG] Change MySQL listen port below (Default: 3306)
:: ========================================================
set MYSQL_PORT=3306
:: ========================================================

cd /d "D:\000GOD"

echo ========================================================
echo             GOD MySQL 5.7 Database Controller
echo ========================================================
echo [CONFIG] Target Listen Port: %MYSQL_PORT%
echo [CONFIG] Install Path: D:\GODserver\phpstudy_pro\Extensions\MySQL5.7.26
echo.

:: 1. Ensure D:\GODserver Junction is ready
if not exist "D:\GODserver\phpstudy_pro" (
    echo [*] Creating D:\GODserver junction...
    mklink /J "D:\GODserver" "D:\000GOD\GODserver20261031" >nul 2>&1
)

:: 2. Check if MySQL is already actively LISTENING on this port
netstat -ano | findstr /R /C:":%MYSQL_PORT% .*LISTENING" >nul
if %errorlevel% == 0 (
    echo [INFO] Port %MYSQL_PORT% is ALREADY LISTENING and running!
    echo [TIP] To restart MySQL, run stop_mysql.bat first.
    goto end
)

:: 3. Clean stale PID lock files
del /F /Q "D:\GODserver\phpstudy_pro\Extensions\MySQL5.7.26\data\*.pid" >nul 2>&1

:: 4. Launch MySQL daemon
echo [*] Starting MySQL Database on Port %MYSQL_PORT%...
cd /d "D:\GODserver\phpstudy_pro\Extensions\MySQL5.7.26"
start "GOD_MySQL_%MYSQL_PORT%" bin\mysqld.exe --defaults-file=my.ini --port=%MYSQL_PORT% --console
cd /d "D:\000GOD"

:: 5. Verify listening state (wait up to 5 seconds)
echo [*] Waiting for MySQL service to bind Port %MYSQL_PORT%...
for /L %%i in (1,1,5) do (
    ping 127.0.0.1 -n 2 >nul
    netstat -ano | findstr /R /C:":%MYSQL_PORT% .*LISTENING" >nul
    if not errorlevel 1 goto success
)

:: If failed:
echo.
echo [ERROR] MySQL port %MYSQL_PORT% did not bind in time!
echo [TIP] Please check if port %MYSQL_PORT% is blocked by other programs.
goto end

:success
echo.
echo ========================================================
echo [SUCCESS] MySQL Database is ACTIVE and listening on Port %MYSQL_PORT%!
echo [CONFIG] User: root  /  Password: 51boshao.com
echo ========================================================

:end
echo.
pause