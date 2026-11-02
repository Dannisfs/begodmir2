@echo off
title GOD Engine Environment and Port Diagnostic Tool

echo ========================================================
echo        GOD Engine Environment Diagnostic (GODenv20261031)
echo ========================================================
echo.

echo [1/3] Checking Developer Tools...
where git >nul 2>&1 && (echo   [OK] Git is installed.) || (echo   [!] Git NOT found in PATH.)

set "FFMPEG_FOUND="
where ffmpeg >nul 2>&1 && set "FFMPEG_FOUND=1"
if exist "%LOCALAPPDATA%\Microsoft\WinGet\Packages\Gyan.FFmpeg_Microsoft.Winget.Source_8wekyb3d8bbwe\ffmpeg-9.0.2-full_build\bin\ffmpeg.exe" set "FFMPEG_FOUND=1"
if defined FFMPEG_FOUND (
    echo   [OK] FFmpeg 9.0.2 is ready.
) else (
    echo   [!] FFmpeg NOT found.
)

if exist "C:\Program Files\7-Zip\7z.exe" (
    echo   [OK] 7-Zip is ready.
) else (
    echo   [!] 7-Zip not found at default path.
)
if exist "D:\softs\vs2022" (
    echo   [OK] Visual Studio 2022 is ready.
) else (
    echo   [!] Visual Studio 2022 not found at D:\softs\vs2022.
)
echo.

echo [2/3] Checking Key Game Ports Status...
for %%p in (88 3306 5000 5100 6000 7000 7200 8090) do (
    netstat -ano | findstr /R ":%%p " >nul && echo   Port %%p: [LISTENING / RUNNING] || echo   Port %%p: [IDLE / NOT STARTED]
)
echo.

echo [3/3] Checking Current IP Settings...
echo -- Web Server edition.xml:
powershell -NoProfile -Command "Get-Content 'D:\000GOD\GODserver20261031\phpstudy_pro\WWW\edition.xml' | Select-String 'URL='"
echo -- Web Server ServerList.txt:
powershell -NoProfile -Command "Get-Content 'D:\000GOD\GODserver20261031\phpstudy_pro\WWW\VER1\ServerList.txt'"
echo -- PC Client accountpassword.xml:
powershell -NoProfile -Command "Get-Content 'D:\000GOD\GODclient20261031\assets\res\config\accountpassword.xml' | Select-String 'URL='"

echo.
echo ========================================================
echo Diagnostic completed! Press any key to exit.
pause >nul
