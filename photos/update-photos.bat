@echo off
cd /d "%~dp0"
title Update Shared Photo Library

echo Scanning photos\ event folders...
echo.

py update-photos.py
if errorlevel 1 python update-photos.py

echo.
pause
