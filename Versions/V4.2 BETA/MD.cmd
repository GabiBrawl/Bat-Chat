@echo off
title Incoming Messages
color 4e
mode con: cols=63 lines=42


:home
if not exist .\chat goto create
cls
echo Time: %time%                          Date: %date%
type .\chat
echo.
timeout /t 1 >nul
goto home


:create
echo. >>.\chat.hys
echo ============================================================== >>.\chat
goto home