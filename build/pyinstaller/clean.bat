@echo off
set arg="main.exe"
taskkill /im %arg% /F 1> NUL 2>&1
run.bat