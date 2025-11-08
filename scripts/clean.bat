@echo off
echo Cleaning build artifacts...

REM Remove compiled JavaScript
if exist template\app\app.js del /F /Q template\app\app.js
if exist template\build\windows.js del /F /Q template\build\windows.js

REM Remove NativeScript build artifacts
if exist template\app\platforms rmdir /S /Q template\app\platforms
if exist template\app\node_modules rmdir /S /Q template\app\node_modules

REM Remove node_modules from root
if exist node_modules rmdir /S /Q node_modules

echo Clean complete!
pause