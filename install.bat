@echo off
setlocal

if "%~1"=="" (
    echo [ERROR] Please provide an install directory as an argument!
    echo Usage: %~nx0 C:\path\to\install
    exit /b 1
)

set INSTALL_PREFIX=%~1

if not exist build (
    mkdir build
)else (
    echo [INFO] Clearing existing build directory...
    rd /s /q build
    mkdir build
)

cd build

echo [INFO] Running CMake configuration...
cmake .. -DCMAKE_INSTALL_PREFIX="%INSTALL_PREFIX%"
if errorlevel 1 (
    echo [ERROR] CMake configuration failed!
    exit /b 1
)

echo [INFO] Building project...
cmake --build . --config Release
if errorlevel 1 (
    echo [ERROR] Build failed!
    exit /b 1
)

echo [INFO] Installing project...
cmake --install .
if errorlevel 1 (
    echo [ERROR] Installation failed!
    exit /b 1
)

if exist "%INSTALL_PREFIX%\lib\lua.dll" (
    echo -- Copying: "%INSTALL_PREFIX%\lib\lua.dll -> %INSTALL_PREFIX%\bin\"
    copy /Y "%INSTALL_PREFIX%\lib\lua.dll" "%INSTALL_PREFIX%\bin\"
)

echo [SUCCESS] Build and installation completed! Installed to: %INSTALL_PREFIX%
exit /b 0