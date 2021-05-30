@echo off
title Help Screen for Commands
mode con: cols=56 lines=10
color 07

if not exist ".\HF.txt" goto create

:run
type HF.txt |More
del HF.txt
exit

:create
echo             Help File for Commands >>.\HF.txt
echo. >>.\HF.txt
echo. >>.\HF.txt
echo. >>.\HF.txt
echo If your input is nothing, go back. >>.\HF.txt
echo If your input is /exit, exit the program. >>.\HF.txt
echo If your input is /cls, delete the history of messages. >>.\HF.txt
echo If your input is /logout, logout the user. >>.\HF.txt
echo If your input is /dcu, delete the current user. >>.\HF.txt
echo If your input is /rp, you will reset your password. >>.\HF.txt
echo. >>.\HF.txt
echo If you click on enter one more tyme, I will exit >>.\HF.txt
echo Exiting... >>.\HF.txt
goto run