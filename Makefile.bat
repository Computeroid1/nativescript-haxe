@echo off

if "%1"=="" goto help
if "%1"=="setup" goto setup
if "%1"=="build" goto build
if "%1"=="android" goto android
if "%1"=="windows" goto windows
if "%1"=="clean" goto clean
goto help

:setup
echo Running setup...
call npm install
call npm install -g nativescript
cd template\app
call npm install
cd ..\..
echo Setup complete!
goto end

:build
echo Building library...
haxe build.hxml
goto end

:android
echo Building for Android...
haxe run_android.hxml
cd template\app
call ns run android
cd ..\..
goto end

:windows
echo Building for Windows...
haxe run_windows.hxml
goto end

:clean
echo Cleaning build artifacts...
if exist template\app\app.js del /F /Q template\app\app.js
if exist template\build\windows.js del /F /Q template\build\windows.js
echo Clean complete!
goto end

:help
echo Usage: .\Makefile.bat [command]
echo.
echo Commands:
echo   setup    - Install dependencies
echo   build    - Build library
echo   android  - Build and run Android
echo   windows  - Build for Windows
echo   clean    - Clean build artifacts
goto end

:end