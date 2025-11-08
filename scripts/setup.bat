@echo off
echo Setting up nativescript-haxe project...
echo.

REM Check if Node.js is installed
where node >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Node.js is not installed or not in PATH
    echo Please install Node.js from https://nodejs.org/
    pause
    exit /b 1
)

REM Check if npm is installed
where npm >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: npm is not installed or not in PATH
    echo Please install Node.js from https://nodejs.org/
    pause
    exit /b 1
)

echo Installing Node.js dependencies...
call npm install
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Failed to install Node.js dependencies
    pause
    exit /b 1
)

echo.
echo Setting up NativeScript app...
cd template\app
call npm install
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Failed to install NativeScript dependencies
    cd ..\..
    pause
    exit /b 1
)
cd ..\..

REM Check if NativeScript CLI is installed
where ns >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo.
    echo NativeScript CLI not found. Installing globally...
    call npm install -g nativescript
    if %ERRORLEVEL% NEQ 0 (
        echo ERROR: Failed to install NativeScript CLI
        echo You may need administrator privileges
        pause
        exit /b 1
    )
)

echo.
echo Setup complete!
echo.
echo Next steps:
echo   1. To build the library: haxe build.hxml
echo   2. To build for Android: haxe run_android.hxml
echo   3. To build for Windows: haxe run_windows.hxml
echo.
echo For Android development, you'll also need:
echo   - Android Studio
echo   - Android SDK
echo   - NativeScript environment: ns doctor android
echo.
pause