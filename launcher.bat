@echo off
regedit /s .\data\execpol.reg
powershell.exe -ExecutionPolicy BYPASS -NoLogo -file .\data\menu.ps1
