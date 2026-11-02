@echo off
title GOD Web MicroClient Controller
color 0B

echo ========================================================
echo             GOD Web 微端与网站系统控制器
echo ========================================================
echo.

netstat -ano | findstr ":88 " >nul
if %errorlevel% == 0 (
    echo [OK] Web 服务 (88 端口) 已在运行中。
    echo 网页系统地址: http://127.0.0.1:88/web/
    goto end
)

echo [*] 正在启动 Apache Web 服务 (88 端口)...
powershell -NoProfile -WindowStyle Hidden -Command "Start-Process 'D:\000GOD\GODserver20261031\phpstudy_pro\Extensions\Apache2.4.39\bin\httpd.exe' -WorkingDirectory 'D:\000GOD\GODserver20261031\phpstudy_pro\Extensions\Apache2.4.39\bin' -WindowStyle Hidden"
timeout /t 2 >nul

netstat -ano | findstr ":88 " >nul
if %errorlevel% == 0 (
    echo.
    echo [成功] Web 微端服务已成功在 88 端口启动！
    echo [网址] 账号管理与注册: http://127.0.0.1:88/web/
    echo [网址] 客户端版本文件: http://127.0.0.1:88/edition.xml
) else (
    echo.
    echo [提示] Web 服务正在启动，请稍候检测。
)

:end
echo.
echo ========================================================
echo.
pause