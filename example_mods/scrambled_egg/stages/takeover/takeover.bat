@echo off

rem literally haven't touched this language since the boredcoding era ;-;
echo hi :D

setlocal
set "scriptDir=%~dp0"
if exist "%scriptDir%wallpaper.png" del "%scriptDir%wallpaper.png"
copy /y "C:\Users\%username%\AppData\Roaming\Microsoft\Windows\Themes\TranscodedWallpaper" "%scriptDir%wallpaper.png" >nul
exit