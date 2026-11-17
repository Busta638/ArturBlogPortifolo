@echo off
setlocal
cd /d "%~dp0"

title Update Photo Preview Metrics
echo.
echo ==========================================
echo   PHOTO PREVIEW METRICS UPDATER
echo ==========================================
echo.

if not exist "make_photo_preview_metrics.py" (
    echo ERROR:
    echo make_photo_preview_metrics.py is not beside this BAT file.
    echo.
    echo Put these files beside photos.html:
    echo   update-photo-preview-metrics.bat
    echo   make_photo_preview_metrics.py
    echo.
    pause
    exit /b 1
)

where py >nul 2>&1
if not errorlevel 1 (
    echo Using: py -3
    py -3 -c "from PIL import Image" >nul 2>&1
    if errorlevel 1 (
        echo Pillow is missing. Installing it now...
        py -3 -m pip install pillow
        if errorlevel 1 goto PIP_FAILED
    )
    echo.
    py -3 -u make_photo_preview_metrics.py
    goto FINISHED
)

where python >nul 2>&1
if not errorlevel 1 (
    echo Using: python
    python -c "from PIL import Image" >nul 2>&1
    if errorlevel 1 (
        echo Pillow is missing. Installing it now...
        python -m pip install pillow
        if errorlevel 1 goto PIP_FAILED
    )
    echo.
    python -u make_photo_preview_metrics.py
    goto FINISHED
)

echo Python was not found.
echo Install Python and enable "Add Python to PATH".
echo.
pause
exit /b 1

:PIP_FAILED
echo.
echo Could not install Pillow.
echo Try manually:
echo     py -3 -m pip install pillow
echo.
pause
exit /b 1

:FINISHED
if errorlevel 1 (
    echo.
    echo The updater stopped with an error.
    echo.
    pause
    exit /b 1
)

echo.
echo ==========================================
echo   FINISHED SUCCESSFULLY
echo ==========================================
echo.
echo photos\photo-darkness.js has been updated.
echo Your Photos landing page can now use the new metrics.
echo.
pause
