@echo off
setlocal
cd /d "%~dp0"

title Update Photo Ink Quality
echo.
echo ==========================================
echo   PHOTO INK QUALITY UPDATER
echo ==========================================
echo.

if not exist "make_photo_darkness_fixed_v3.py" (
    echo ERROR: make_photo_darkness_fixed_v3.py is not beside this BAT file.
    echo Folder: %CD%
    echo.
    pause
    exit /b 1
)

where py >nul 2>&1
if not errorlevel 1 (
    echo Using: py -3
    py -3 -c "from PIL import Image" >nul 2>&1
    if errorlevel 1 py -3 -m pip install pillow
    echo.
    py -3 -u make_photo_darkness_fixed_v3.py
    goto FINISHED
)

where python >nul 2>&1
if not errorlevel 1 (
    echo Using: python
    python -c "from PIL import Image" >nul 2>&1
    if errorlevel 1 python -m pip install pillow
    echo.
    python -u make_photo_darkness_fixed_v3.py
    goto FINISHED
)

echo Python was not found.
pause
exit /b 1

:FINISHED
if errorlevel 1 (
    echo.
    echo Updater stopped with an error.
    pause
    exit /b 1
)

echo.
echo ==========================================
echo   FINISHED SUCCESSFULLY
echo ==========================================
echo.
echo photos\photo-darkness.js now contains:
echo   - original darkness
echo   - estimated ink coverage
echo   - heavy black coverage
echo.
pause
