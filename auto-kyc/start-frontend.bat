@echo off
echo 🎨 Starting Auto-KYC Frontend...
echo.

REM Check if Node.js is installed
node --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Node.js is not installed or not in PATH
    echo Please install Node.js and try again
    pause
    exit /b 1
)

REM Check if npm is installed
npm --version >nul 2>&1
if errorlevel 1 (
    echo ❌ npm is not installed or not in PATH
    echo Please install npm and try again
    pause
    exit /b 1
)

echo ✅ Node.js and npm are available
echo.

REM Check if node_modules exists
if not exist "node_modules" (
    echo 📦 Installing dependencies...
    npm install
    if errorlevel 1 (
        echo ❌ Failed to install dependencies
        pause
        exit /b 1
    )
    echo ✅ Dependencies installed successfully
)

REM Set API base URL for frontend
set API_BASE_URL=http://localhost:8000/api

echo 🌐 Starting React development server...
echo 🎯 Frontend URL: http://localhost:3000
echo 🔗 Backend API: http://localhost:8000/api
echo 📚 API Documentation: http://localhost:8000/docs
echo.

REM Start the React development server
npm start

echo.
echo 🎉 Auto-KYC Frontend started successfully!
echo Press Ctrl+C to stop the server
pause
