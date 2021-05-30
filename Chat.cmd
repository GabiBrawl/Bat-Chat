@echo off
mode con: cols=70 lines=15
title Command Prompt Chat
color 07
if not exist users goto creatediruser

::--------------------
::Below is the code to log-in to the program. 
::--------------------
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
echo Info: Your password will be invisible.
echo.
setlocal
set /P "=_" < NUL > "Enter password"
findstr /A:07 /V "*" "Enter password" NUL > CON
del "Enter password"
set /P "password="
cls

::Now we have the username and password set. We can now check to see if they are correct.
::First we need to see if the username exists. 

if exist ".\users\%username%.dll" goto password_check
::If the username does not exist, we will now display
::Incorrect Credentials Message and return to login
:incorrect_credentials
cls
echo I'm sorry, but those credentials were not found. Please try again.
timeout /t 3 >nul
goto login


::If the username did exist, we will now check to see if the password matches.
:password_check

::First, we need to get the password from the file and set it as a variable.
set /p password_file=<".\users\%username%.dll"
::Now, Compare the two
if %password_file%==%password% goto correct_credentials

::if they do not match, go again to incorrect credentials
goto incorrect_credentials

:create_account
::Here we create an account. We need to ask for a username and password.
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
::Clear the screen, re-draw and ask for password
cls
echo _____________________
echo Create an Account
echo ---------------------
echo.
echo.
echo Please enter your information...
echo.
set /p new_password=Password:

::Now that we have the information, we need to 
::write it to the account file. We use the .dll extention
echo %new_password% >".\users\%new_username%.dll"

::now we confirm creation and go home
echo.
echo Account Successfully Created!
timeout /t 2 >nul
goto login



:correct_credentials
::If credentials were correct, start up the message viewer and begin asking for input
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
goto cco


:cco
::If credentials were correct, start up the message viewer and begin asking for input
start cmd /c ".\PBMD.cmd"
timeout /t 3
title Chatting as %username%
echo. >>.\chat.txt
echo System: %username% joined the room at %time% >>chat.txt
echo. >>.\chat.txt
goto read_messages


:read_messages
color 1F

cls
mode con: cols=54 lines=4
set /p input=Message:
::If input is nothing, go back
if "%input%"=="" goto read_messages
::If input is /exit, exit the program.
if "%input%"=="/exit" goto exit
::If input is /cls, delete the history of messages.
if "%input%"=="/cls" goto cls
::If input is /cls -admin, delete the history of messages.
if "%input%"=="/cls -admin" goto cls_admin
::If input is /cls -admin -s, delete the history of messages.
if "%input%"=="/cls -admin -s" goto cls_admin_s
::If input is /logout, logout the user.
if "%input%"=="/logout" goto logout
::If input is /dcu, delete the current user.
if "%input%"=="/dcu" goto dcu
::If input is /help, open the help file.
if "%input%"=="/help" goto help
::If input is /rp, reset the password of the current user.
if "%input%"=="/rp" goto passreset
::If input is /md, run the message displayer.
if "%input%"=="/md" start MD.cmd


::Input message into chat file
echo %username%: %input% >>chat.txt
::reset the input to prevent spam
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