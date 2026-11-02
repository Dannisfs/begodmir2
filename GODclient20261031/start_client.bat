@echo off
title GOD Client Launcher
color 0B

echo ========================================================
echo             Launching GOD Mir2 PC Client
echo ========================================================
echo.

cd /d "D:\000GOD\GODclient20261031"

if not exist "PCClient_Latest.exe" (
    echo [ERROR] PCClient_Latest.exe was not found!
    echo Looking for available executables:
    dir *.exe
    echo.
    pause
    exit /b 1
)

echo [*] Starting PCClient_Latest.exe...
start "" "D:\000GOD\GODclient20261031\PCClient_Latest.exe"

echo [OK] Client process started successfully!
echo This window will close in 3 seconds...
ping 127.0.0.1 -n 3 >nul
exit
