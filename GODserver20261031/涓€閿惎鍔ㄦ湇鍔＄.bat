@echo off
title GOD引擎 一键启动服务控制台
color 0A

echo ========================================================
echo             GOD引擎 一键启动服务中�?echo ========================================================
echo.

:: 1. 检查并确保 D:\GODserver 软连接就�?if not exist "D:\GODserver\Mirserver" (
    echo [*] 正在初始�?D:\GODserver 目录映射...
    mklink /J "D:\GODserver" "D:\000GOD\GODserver20261031" >nul 2>&1
)

:: 2. 启动 Apache (Web微端服务 端口88)
netstat -ano | findstr ":88 " >nul
if errorlevel 1 (
    echo [*] 正在启动 Web 微端服务 (Apache 端口88)...
    start "" /D "D:\GODserver\phpstudy_pro\Extensions\Apache2.4.39\bin" "D:\GODserver\phpstudy_pro\Extensions\Apache2.4.39\bin\httpd.exe"
    timeout /t 2 >nul
) else (
    echo [OK] Web 微端服务 (端口88) 已在运行�?)

:: 3. 启动 MySQL 数据�?(端口3306)
netstat -ano | findstr ":3306 " >nul
if errorlevel 1 (
    echo [*] 正在启动 MySQL 数据库服�?(端口3306)...
    start "" /D "D:\GODserver\phpstudy_pro\Extensions\MySQL5.7.26" "D:\GODserver\phpstudy_pro\Extensions\MySQL5.7.26\bin\mysqld.exe" --defaults-file="D:\GODserver\phpstudy_pro\Extensions\MySQL5.7.26\my.ini" --console
    timeout /t 2 >nul
) else (
    echo [OK] MySQL 数据库服�?(端口3306) 已在运行�?)

:: 4. 启动主控制台 GameCenter.exe
echo [*] 正在唤醒游戏总控�?GameCenter...
start "" /D "D:\GODserver\Mirserver" "D:\GODserver\Mirserver\GameCenter.exe"

:: 5. 启动网关 Gateway
if exist "D:\GODserver\Mirserver\Gateway\Gateway4.3.exe" (
    echo [*] 正在唤醒游戏网关 Gateway4.3...
    start "" /D "D:\GODserver\Mirserver\Gateway" "D:\GODserver\Mirserver\Gateway\Gateway4.3.exe"
)

echo.
echo ========================================================
echo [恭喜] 底层 Web、数据库与控制台已全部拉起！
echo.
echo 【接下来的操作步骤】：
echo   1. 在弹出的【GameCenter】窗口中，点击【启动游戏服务器】；
echo   2. 等待各网关与 M2 界面完全加载完毕 (�?5~15 �?�?echo   3. 双击根目录下的【一键启动PC客户�?bat】即可进入游戏！
echo ========================================================
echo.
pause