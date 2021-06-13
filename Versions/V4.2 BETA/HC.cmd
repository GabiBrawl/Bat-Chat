@echo off
title Help Screen for Colors
mode con: cols=56 lines=10
color 07

if not exist ".\HFC.txt" goto create

:run
type HFC.txt |More
del HFC.txt
exit

:create
echo             Help File for Colors >>.\HFC.txt
echo. >>.\HFC.txt
echo. >>.\HFC.txt
echo. >>.\HFC.txt
echo 0 = Black       8 = Gray >>.\HFC.txt
echo 1 = Blue        9 = Light Blue >>.\HFC.txt
echo 2 = Green       A = Light Green >>.\HFC.txt
echo 3 = Aqua        B = Light Aqua >>.\HFC.txt
echo 4 = Red         C = Light Red >>.\HFC.txt
echo 5 = Purple      D = Light Purple >>.\HFC.txt
echo 6 = Yellow      E = Light Yellow >>.\HFC.txt
echo 7 = White       F = Bright White >>.\HFC.txt
echo. >>.\HFC.txt
echo If you click on enter one more tyme, I will exit >>.\HFC.txt
echo Exiting... >>.\HFC.txt
goto run