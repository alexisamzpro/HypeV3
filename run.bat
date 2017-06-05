@echo off
:loop
start CitizenMP.Server.exe %*
timeout /t 86000 >null
taskkill /f /im CitizenMP.Server.exe >nul
cd "C:\cfx-server\cache\http-files"
del /F /Q 
timeout /t 60 >null
goto loop