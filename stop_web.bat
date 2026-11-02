@echo off
title Stop GOD Web Service
color 0C

echo ========================================================
echo             停止 GOD Web 微端服务
echo ========================================================
echo.

echo [*] 正在停止 Apache Web 进程...
taskkill /f /im httpd.exe >nul 2>&1

echo.
echo [成功] Web 服务进程已停止！
echo.
pause