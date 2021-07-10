@echo off
mode con: cols=70 lines=15
title Command Prompt Chat
color 07
if not exist users goto creatediruser


:login
title Command Prompt Chat LogIn
color 07
mode con: cols=66 lines=15
cls
echo ---------------------
echo Log-In to Bat-Chat
echo.
echo.
echo.
echo Please type your username and press enter.
echo [To Create an Account, type 1 and Press Enter]
echo.
set /p username=Username:
::Check if input is 1 to go create an account
if %username% == 1 goto create_account
if %username% == /ladmin goto ccs
cls

echo ---------------------
echo Log-In to Bat-Chat
echo.
echo.
echo.
echo Please type your password and press enter.
echo.
set /p password=Password:


if exist ".\users\%username%.dll" goto password_check
cls
echo I'm sorry, but those credentials were not found. Please try again.
timeout /t 3 >nul
goto login


set /p password_file=<".\users\%username%.dll"
if %password_file%==%password% goto correct_credentials
goto incorrect_credentials


cls
echo _____________________
echo Create an Account
echo ---------------------
echo.
echo.
echo Please enter your information...
echo.
set /p new_username=Username:
goto usr_check

:usr_check
if exist ".\users\%new_username%.dll" (goto usr_error) else (goto usr_password)

:usr_error
cls
echo Sorry. This username is taken, pick another one!
timeout /t 3 >nul
goto create_account

:usr_password
cls
echo _____________________
echo Create an Account
echo ---------------------
echo.
echo.
echo Please enter your information...
echo.
set /p new_password=Password:
echo %new_password% >".\users\%new_username%.dll"
echo.
echo Account Successfully Created!
timeout /t 2 >nul
goto login



:correct_credentials
start cmd /c ".\PBMD.cmd"
timeout /t 3
title Chatting as %username%
echo. >>.\chat.txt
echo System: %username% joined the room at %time% >>chat.txt
echo. >>.\chat.txt
goto read_messages


:ccs
cls
echo ---------------------
echo Secret Session Log-in
echo.
echo.
echo.
echo Please type your username and press enter.
echo.
set /p username=Username:
cls
goto ccs



:read_messages
color 1F

cls
mode con: cols=54 lines=4
set /p input=Messages
if "%input%"=="" goto read_messages
if "%input%"=="/exit" goto exit
if "%input%"=="/cls" goto cls
if "%input%"=="/cls -admin" goto cls_admin
if "%input%"=="/cls -admin -s" goto cls_admin_s
if "%input%"=="/logout" goto logout
if "%input%"=="/dcu" goto dcu
if "%input%"=="/help" goto help
if "%input%"=="/rp" goto passreset
if "%input%"=="/md" start MD.cmd

echo %username%: %input% >>chat.txt
set input=
goto read_messages


:exit
echo. >>.\chat.txt
echo System: %username% left the room >>chat.txt
echo. >>.\chat.txt
exit


:cls
del chat.txt
timeout /t 2
echo. >>.\chat.txt
echo System: %username% cleared the screen >>chat.txt
echo. >>.\chat.txt
goto read_messages


:cls_admin
del chat.txt
timeout /t 2
echo. >>.\chat.txt
echo System: An admin cleared the screen >>chat.txt
echo. >>.\chat.txt
goto read_messages


:cls_admin_s
del chat.txt
goto read_messages


:logout
echo. >>.\chat.txt
echo System: %username% left the room >>chat.txt
echo. >>.\chat.txt
goto login


:help
start help.cmd
goto read_messages


:creatediruser
md users
goto login


:dcu
del ".\users\%username%.dll"
echo. >>.\chat.txt
echo System: %username% deleted his account >>chat.txt
echo. >>.\chat.txt
goto login


:passreset
mode con: cols=54 lines=15
color 07
cls
set /p new_reset_password=New password:
break>".\users\%username%.dll"
echo %new_reset_password% >".\users\%username%.dll"
cls
echo New Password set!
timeout /t 2 >nul
goto read_messages
