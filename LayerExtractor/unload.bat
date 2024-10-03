REM Description: This batch file runs the unloads the bundle from the registry hive.
REM Written by: Madhukar Moogala
REM Date: 03/10/2024
@echo off
REM Prompt for the Bundle directory
set /p BundleDir=Enter the Bundle directory path (e.g., D:/Work/Projects/2024/local-da4a-usage/LayerExtractor/Bundle/LayerExtractor.bundle): 

REM Get CurVer from the registry for AutoCAD R25.0
FOR /F "tokens=2*" %%A IN ('reg query "HKEY_CURRENT_USER\SOFTWARE\Autodesk\AutoCAD\R25.0" /v CurVer') DO SET CurVer=%%B

REM Check if CurVer is set
IF "%CurVer%"=="" (
    echo Failed to retrieve CurVer.
    exit /b 1
)

REM Delete the LayerExtractor  command key
reg delete "HKEY_CURRENT_USER\SOFTWARE\Autodesk\AutoCAD\R25.0\%CurVer%\Applications\LayerExtractor" /f

REM Delete the bundle module key
reg delete "HKEY_CURRENT_USER\SOFTWARE\Autodesk\AutoCAD\R25.0\ACAD-8101:409\Loaded\%BundleDir%" /f

echo Registry keys deleted successfully.
