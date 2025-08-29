@echo off
setlocal

REM ?????????????
if "%~1"=="" (
    echo [ERROR] Please provide an install directory as an argument!
    echo Usage: %~nx0 C:\path\to\install
    exit /b 1
)

REM ??????
set INSTALL_PREFIX=%~1

REM ?? build ?????????
if not exist build (
    mkdir build
)else (
    echo [INFO] Clearing existing build directory...
    rd /s /q build
    mkdir build
)

cd build

REM ?? CMake ??
echo [INFO] Running CMake configuration...
cmake .. -DCMAKE_INSTALL_PREFIX="%INSTALL_PREFIX%"
if errorlevel 1 (
    echo [ERROR] CMake configuration failed!
    exit /b 1
)

REM ????
echo [INFO] Building project...
cmake --build . --config Release
if errorlevel 1 (
    echo [ERROR] Build failed!
    exit /b 1
)

REM ????
echo [INFO] Installing project...
cmake --install .
if errorlevel 1 (
    echo [ERROR] Installation failed!
    exit /b 1
)

echo [SUCCESS] Build and installation completed! Installed to: %INSTALL_PREFIX%
exit /b 0