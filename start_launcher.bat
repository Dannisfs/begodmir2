@echo off
title GOD Legend of Mir 2 Launcher
cd /d "D:\000GOD\GODlauncher20261031"
if exist "GOD_Launcher_New.exe" (
    copy /y "GOD_Launcher_New.exe" "GOD_Launcher.exe" >nul 2>&1
)
if exist "GOD_Launcher.exe" (
    start "" "D:\000GOD\GODlauncher20261031\GOD_Launcher.exe"
) else (
    start "" "D:\000GOD\GODlauncher20261031\GOD_Launcher_New.exe"
)
exit
