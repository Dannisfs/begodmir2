@echo off
title GOD Game Server Launcher
color 0A

cd /d "D:\000GOD"

echo ========================================================
echo             GOD Legend of Mir 2 Server Launcher
echo ========================================================
echo.

:: 1. Ensure D:\GODserver Junction is ready
if not exist "D:\GODserver\Mirserver" (
    echo [*] Creating D:\GODserver directory junction...
    mklink /J "D:\GODserver" "D:\000GOD\GODserver20261031" >nul 2>&1
)

:: 2. Check Web MicroClient Port 88
netstat -ano | findstr /R /C:":88 .*LISTENING" >nul
if %errorlevel% == 0 (
    echo [OK] Web MicroClient Service Port 88 is running.
) else (
    echo [*] Starting Apache Web MicroClient Port 88...
    cd /d "D:\GODserver\phpstudy_pro\Extensions\Apache2.4.39\bin"
    start "GOD_Apache_88" /min httpd.exe
    cd /d "D:\000GOD"
    ping 127.0.0.1 -n 2 >nul
)

:: 3. Check MySQL Database (Port 3306)
netstat -ano | findstr /R /C:":3306 .*LISTENING" >nul
if %errorlevel% == 0 (
    echo [OK] MySQL Database is running on Port 3306.
) else (
    echo [*] MySQL Port 3306 is not detected. Starting MySQL automatically...
    start "" cmd /c "start_mysql.bat"
    ping 127.0.0.1 -n 3 >nul
)

:: 4. Start GameCenter
echo [*] Launching GameCenter console...
start "" /D "D:\GODserver\Mirserver" "D:\GODserver\Mirserver\GameCenter.exe"

:: 5. Start LoginGate (Port 7000 -> LoginSrv 5500)
if exist "D:\GODserver\Mirserver\LoginGate\LoginGate.exe" (
    echo [*] Launching LoginGate Port 7000...
    cd /d "D:\GODserver\Mirserver\LoginGate"
    start "LoginGate_7000" LoginGate.exe
    cd /d "D:\000GOD"
)

:: 6. Start SelGate (Port 7100 -> DBServer 5100)
if exist "D:\GODserver\Mirserver\SelGate\SelGate.exe" (
    echo [*] Launching SelGate Port 7100...
    cd /d "D:\GODserver\Mirserver\SelGate"
    start "SelGate_7100" SelGate.exe
    cd /d "D:\000GOD"
)

:: 7. Start Gateway 4.3 if exists (Select Server Gate)
if exist "D:\GODserver\Mirserver\Gateway\Gateway4.3.exe" (
    echo [*] Launching Gateway 4.3 Port 8090...
    cd /d "D:\GODserver\Mirserver\Gateway"
    start "Gateway_8090" Gateway4.3.exe
    cd /d "D:\000GOD"
)

echo.
echo ========================================================
echo [READY] Server components launched successfully!
echo.
echo NEXT STEPS:
echo   1. In GameCenter window, click START SERVER button.
echo   2. Run start_launcher.bat to open Launcher and play!
echo ========================================================
echo.
pause