@echo off
cdvirtualenv
cd Scripts
echo iex ^("~\Envs\" + ^$args^[0^] + "\Scripts\activate.ps1"^) > workon.ps1
