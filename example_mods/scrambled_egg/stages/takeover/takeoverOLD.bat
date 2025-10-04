@echo off
setlocal
set "scriptDir=%~dp0"

goto :usage

:usage
echo.
echo Please specify an action to run or choose below:
echo   - Type 'T' to perform the takeover.
echo   - Type 'R' to restore previous settings.
echo.
choice /C TR /N
if "%errorlevel%" EQU "1" goto :takeover
if "%errorlevel%" EQU "2" goto :restore
exit

:takeover
echo.
echo Attempting to take over desktop wallpaper...

if not exist "%scriptDir%replacement.bmp" (
    echo Error: The file 'replacement.bmp' was not found in the script's directory.
    echo Please ensure the image is in the same folder as this script and is named 'replacement.bmp'.
    pause
    exit /b
)

for /f "tokens=2,*" %%a in ('reg query "HKCU\Control Panel\Desktop" /v Wallpaper') do set "currentWallpaperPath=%%b"
copy /y "%currentWallpaperPath%" "%scriptDir%past.png" >nul

reg add "HKCU\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d "%scriptDir%replacement.bmp" /f
reg add "HKCU\Control Panel\Desktop" /v TileWallpaper /t REG_SZ /d 0 /f

echo Wallpaper registry key updated. Waiting 15 seconds for system to process...
timeout /t 15 >nul
RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters
RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters 1, True, 20
echo Desktop wallpaper has been changed.
pause
goto :eof

:restore
echo.
echo Attempting to restore desktop wallpaper...

if not exist "%scriptDir%past.png" (
    echo Error: The file 'past.png' was not found. Have you run the takeover script yet?
    pause
    exit /b
)

reg add "HKCU\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d "%scriptDir%past.png" /f
reg add "HKCU\Control Panel\Desktop" /v TileWallpaper /t REG_SZ /d 0 /f

echo Wallpaper registry key updated. Waiting 15 seconds for system to process...
timeout /t 15 >nul
RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters
RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters 1, True, 20
echo Desktop wallpaper has been restored.
pause
goto :eof
