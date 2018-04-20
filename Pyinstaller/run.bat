@echo off
: VirtualEnv Must be Set, run workon before running run.bat
set main=main
echo Pyinstaller started

: Clean cache
if exist build (
  rmdir /s /q build
)
if exist dist (
  rmdir /s /q dist
)
if exist %main%.spec (
  pyinstaller --onedir %main%.spec
) else (
  pyinstaller --onedir ..\..\%main%.py
)
echo Pyinstaller completed
