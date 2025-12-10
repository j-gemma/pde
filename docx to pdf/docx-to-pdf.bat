@echo off
setlocal enabledelayedexpansion

:: Check if source directory is provided
if "%~1"=="" (
    echo Please provide the source directory.
    pause
    exit /b 1
)

:: Set the source directory
set "source_dir=%~1"

:: Check if directory exists
if not exist "%source_dir%" (
    echo Source directory not found.
    pause
    exit /b 1
)

:: Set the output directory
set "output_dir=%source_dir%\PDFs"

:: Create output directory if it doesn't exist
if not exist "%output_dir%" (
    mkdir "%output_dir%"
)

:: Loop through each .docx file in the source directory
for %%f in ("%source_dir%\*.docx") do (
    :: Set output PDF file path
    set "output_file=!output_dir!\%%~nf.pdf"

    :: Convert the DOCX file to PDF using PowerShell
    powershell -NoProfile -ExecutionPolicy Bypass -Command ^
        "try {
            
        } catch {
            
        }"
)

echo Conversion complete.
pause