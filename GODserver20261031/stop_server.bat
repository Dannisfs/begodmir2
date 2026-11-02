@echo off
title Stop GOD Engine Server and Gates
color 0C

cd /d "D:\000GOD"

echo ========================================================
echo          Stopping GOD Server and All Gateway Windows
echo ========================================================
echo.

echo [*] Closing RunGate and Gateway 4.3...
taskkill /F /IM RunGate.exe >nul 2>&1
taskkill /F /IM Gateway4.3.exe >nul 2>&1
taskkill /F /IM LoginGate.exe >nul 2>&1
taskkill /F /IM SelGate.exe >nul 2>&1

echo [*] Stopping Game Engine and Servers...
taskkill /F /IM GameServer.exe >nul 2>&1
taskkill /F /IM DBServer.exe >nul 2>&1
taskkill /F /IM LoginSrv.exe >nul 2>&1
taskkill /F /IM LogServer.exe >nul 2>&1
taskkill /F /IM GameCenter.exe >nul 2>&1

echo.
echo ========================================================
echo [SUCCESS] All Game Server and Gateway windows are CLOSED!
echo ========================================================
echo.
pause
