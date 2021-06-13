@echo off

color 4e

mode con: cols=63 lines=42

title Incoming Messages


:home
if not exist ".\chat.txt" goto create
cls
echo Time: %time%                          Date: %date%
type .\chat.txt
echo.
timeout /t 1 >nul
goto home


:create
echo. >>.\chat.txt
echo =============================================================== >>.\chat.txt
goto home