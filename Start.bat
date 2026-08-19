net session >nul 2>nul

IF %ERRORLEVEL% EQU 0 (
    pushd %~dp0
    powershell.exe -File .\Setup.ps1 -ExecutionPolicy Bypass
) ELSE (
    powershell.exe -Command "Start-Process '%~f0' -Verb RunAs"
)