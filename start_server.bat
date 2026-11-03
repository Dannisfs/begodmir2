@echo off
title GOD Legend of Mir 2 - Server Full Launcher
color 0A

cd /d "D:\000GOD"

echo ========================================================
echo       GOD Legend of Mir 2 - Full Server Launcher
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
    echo [OK] Web MicroClient Port 88 is running.
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
    echo [OK] MySQL Database Port 3306 is running.
) else (
    echo [*] Starting MySQL Database Port 3306...
    start "" cmd /c "start_mysql.bat"
    ping 127.0.0.1 -n 3 >nul
)

:: 4. Start DBServer (Port 5100)
tasklist /FI "IMAGENAME eq DBServer.exe" 2>nul | findstr /i "DBServer.exe" >nul
if %errorlevel% == 0 (
    echo [OK] DBServer is already running.
) else (
    if exist "D:\GODserver\Mirserver\DBServer\DBServer.exe" (
        echo [*] Starting DBServer Database Port 5100...
        cd /d "D:\GODserver\Mirserver\DBServer"
        start "DBServer_5100" DBServer.exe
        cd /d "D:\000GOD"
    )
)

:: 5. Start LoginSrv (Port 5500)
tasklist /FI "IMAGENAME eq LoginSrv.exe" 2>nul | findstr /i "LoginSrv.exe" >nul
if %errorlevel% == 0 (
    echo [OK] LoginSrv is already running.
) else (
    if exist "D:\GODserver\Mirserver\LoginSrv\LoginSrv.exe" (
        echo [*] Starting LoginSrv Account Login Port 5500...
        cd /d "D:\GODserver\Mirserver\LoginSrv"
        start "LoginSrv_5500" LoginSrv.exe
        cd /d "D:\000GOD"
    )
)

:: 6. Start LogDataServer (Port 10000)
tasklist /FI "IMAGENAME eq LogDataServer.exe" 2>nul | findstr /i "LogDataServer.exe" >nul
if %errorlevel% == 0 (
    echo [OK] LogDataServer is already running.
) else (
    if exist "D:\GODserver\Mirserver\LogServer\LogDataServer.exe" (
        echo [*] Starting LogDataServer Port 10000...
        cd /d "D:\GODserver\Mirserver\LogServer"
        start "LogServer_10000" LogDataServer.exe
        cd /d "D:\000GOD"
    )
)

:: Wait 2 seconds for DBServer and LoginSrv to establish database connections
ping 127.0.0.1 -n 3 >nul

:: 7. Start GameServer (Port 5000)
tasklist /FI "IMAGENAME eq GameServer.exe" 2>nul | findstr /i "GameServer.exe" >nul
if %errorlevel% == 0 (
    echo [OK] GameServer is already running.
) else (
    if exist "D:\GODserver\Mirserver\Mir200\GameServer.exe" (
        echo [*] Starting GameServer Game Engine Port 5000...
        cd /d "D:\GODserver\Mirserver\Mir200"
        start "GameServer_5000" GameServer.exe
        cd /d "D:\000GOD"
    )
)

:: Wait 3 seconds for GameServer initialization
ping 127.0.0.1 -n 4 >nul

:: 8. Start RunGate (Port 7200 -> GameServer 5000)
tasklist /FI "IMAGENAME eq RunGate.exe" 2>nul | findstr /i "RunGate.exe" >nul
if %errorlevel% == 0 (
    echo [OK] RunGate is already running.
) else (
    if exist "D:\GODserver\Mirserver\RunGate\RunGate.exe" (
        echo [*] Starting RunGate Game Gate Port 7200...
        cd /d "D:\GODserver\Mirserver\RunGate"
        start "RunGate_7200" RunGate.exe
        cd /d "D:\000GOD"
    )
)

:: 9. Start LoginGate (Port 7000 -> LoginSrv 5500)
tasklist /FI "IMAGENAME eq LoginGate.exe" 2>nul | findstr /i "LoginGate.exe" >nul
if %errorlevel% == 0 (
    echo [OK] LoginGate is already running.
) else (
    if exist "D:\GODserver\Mirserver\LoginGate\LoginGate.exe" (
        echo [*] Starting LoginGate Port 7000...
        cd /d "D:\GODserver\Mirserver\LoginGate"
        start "LoginGate_7000" LoginGate.exe
        cd /d "D:\000GOD"
    )
)

:: 10. Start SelGate (Port 7100 -> DBServer 5100)
tasklist /FI "IMAGENAME eq SelGate.exe" 2>nul | findstr /i "SelGate.exe" >nul
if %errorlevel% == 0 (
    echo [OK] SelGate is already running.
) else (
    if exist "D:\GODserver\Mirserver\SelGate\SelGate.exe" (
        echo [*] Starting SelGate Port 7100...
        cd /d "D:\GODserver\Mirserver\SelGate"
        start "SelGate_7100" SelGate.exe
        cd /d "D:\000GOD"
    )
)

:: 11. Start Gateway 4.3 (Port 8090 Select Server Gate)
tasklist /FI "IMAGENAME eq Gateway4.3.exe" 2>nul | findstr /i "Gateway4.3.exe" >nul
if %errorlevel% == 0 (
    echo [OK] Gateway 4.3 is already running.
) else (
    if exist "D:\GODserver\Mirserver\Gateway\Gateway4.3.exe" (
        echo [*] Starting Gateway 4.3 Port 8090...
        cd /d "D:\GODserver\Mirserver\Gateway"
        start "Gateway_8090" Gateway4.3.exe
        cd /d "D:\000GOD"
    )
)

:: 12. Start GameCenter Console Monitor
tasklist /FI "IMAGENAME eq GameCenter.exe" 2>nul | findstr /i "GameCenter.exe" >nul
if %errorlevel% == 0 (
    echo [OK] GameCenter is already running.
) else (
    if exist "D:\GODserver\Mirserver\GameCenter.exe" (
        echo [*] Starting GameCenter Console Monitor...
        cd /d "D:\GODserver\Mirserver"
        start "GameCenter" GameCenter.exe
        cd /d "D:\000GOD"
    )
)

ping 127.0.0.1 -n 2 >nul

echo.
echo ========================================================
echo             Server Status Verification
echo ========================================================
netstat -ano | findstr /R /C:":88 .*LISTENING" >nul && echo  [OK] Port 88   - Web MicroClient || echo  [!!] Port 88   - Web NOT running
netstat -ano | findstr /R /C:":3306 .*LISTENING" >nul && echo  [OK] Port 3306 - MySQL Database   || echo  [!!] Port 3306 - MySQL NOT running
netstat -ano | findstr /R /C:":5100 .*LISTENING" >nul && echo  [OK] Port 5100 - DBServer DB      || echo  [!!] Port 5100 - DBServer NOT running
netstat -ano | findstr /R /C:":5500 .*LISTENING" >nul && echo  [OK] Port 5500 - LoginSrv Acc     || echo  [!!] Port 5500 - LoginSrv NOT running
netstat -ano | findstr /R /C:":5000 .*LISTENING" >nul && echo  [OK] Port 5000 - GameServer M2    || echo  [!!] Port 5000 - GameServer NOT running
netstat -ano | findstr /R /C:":7000 .*LISTENING" >nul && echo  [OK] Port 7000 - LoginGate        || echo  [!!] Port 7000 - LoginGate NOT running
netstat -ano | findstr /R /C:":7100 .*LISTENING" >nul && echo  [OK] Port 7100 - SelGate          || echo  [!!] Port 7100 - SelGate NOT running
netstat -ano | findstr /R /C:":7200 .*LISTENING" >nul && echo  [OK] Port 7200 - RunGate Game     || echo  [!!] Port 7200 - RunGate NOT running
netstat -ano | findstr /R /C:":8090 .*LISTENING" >nul && echo  [OK] Port 8090 - Gateway 4.3      || echo  [!!] Port 8090 - Gateway NOT running
echo ========================================================
echo [SUCCESS] All GOD Legend of Mir 2 Server components READY!
echo.
echo You can now run start_launcher.bat to enter the game!
echo ========================================================
echo.
pause