@echo off
echo 🚀 Starting Auto-KYC Backend Server...
echo.

REM Check if Python is installed
python --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Python is not installed or not in PATH
    echo Please install Python 3.10+ and try again
    pause
    exit /b 1
)

REM Check if required packages are installed
echo 📦 Checking required packages...
python -c "import fastapi" 2>nul
if errorlevel 1 (
    echo ❌ FastAPI not installed. Installing...
    pip install fastapi
)

python -c "import uvicorn" 2>nul
if errorlevel 1 (
    echo ❌ Uvicorn not installed. Installing...
    pip install uvicorn
)

python -c "import python-multipart" 2>nul
if errorlevel 1 (
    echo ❌ python-multipart not installed. Installing...
    pip install python-multipart
)

echo ✅ Dependencies checked
echo.

REM Create temp directory
if not exist "temp_imgs" mkdir temp_imgs

echo 🌐 Starting FastAPI server on http://localhost:8000
echo 📚 API Documentation: http://localhost:8000/docs
echo 🔍 Health Check: http://localhost:8000/api/health
echo.

REM Start the server
python main.py

echo.
echo 🎉 Auto-KYC Backend started successfully!
echo Press Ctrl+C to stop the server
pause
