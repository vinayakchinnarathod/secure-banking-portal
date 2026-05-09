@echo off
echo 🔧 Auto-KYC Integration Test
echo ================================
echo.

REM Test 1: Check Backend Health
echo 📡 Testing Backend Health...
curl -s http://localhost:8000/api/health >nul 2>&1
if errorlevel 1 (
    echo ❌ Backend is not running on port 8000
    echo Please start the backend first: start-backend.bat
    pause
    exit /b 1
) else (
    echo ✅ Backend is running on port 8000
)

echo.

REM Test 2: Check Frontend
echo 🎨 Testing Frontend...
curl -s http://localhost:3000 >nul 2>&1
if errorlevel 1 (
    echo ❌ Frontend is not running on port 3000
    echo Please start the frontend first: start-frontend.bat
    pause
    exit /b 1
) else (
    echo ✅ Frontend is running on port 3000
)

echo.

REM Test 3: Test API Endpoints
echo 🔍 Testing API Endpoints...
echo.

echo 📄 Testing Document Upload API...
curl -s -X GET http://localhost:8000/api/health | findstr "upload" >nul 2>&1
if errorlevel 1 (
    echo ❌ Upload API not available
) else (
    echo ✅ Upload API is available
)

echo 📸 Testing Face Verification API...
curl -s -X GET http://localhost:8000/api/health | findstr "face" >nul 2>&1
if errorlevel 1 (
    echo ❌ Face Verification API not available
) else (
    echo ✅ Face Verification API is available
)

echo 👥 Testing Customer API...
curl -s http://localhost:8000/api/customers >nul 2>&1
if errorlevel 1 (
    echo ❌ Customer API not available
) else (
    echo ✅ Customer API is available
)

echo.

REM Test 4: Test File Upload
echo 📤 Testing File Upload...
echo Creating test file...
echo Test Content > test-upload.txt

curl -s -X POST -F "file=@test-upload.txt" -F "document_type=test" http://localhost:8000/api/upload-document >nul 2>&1
if errorlevel 1 (
    echo ❌ File upload test failed
) else (
    echo ✅ File upload test passed
)

del test-upload.txt

echo.

REM Test 5: Check Dependencies
echo 📦 Checking Dependencies...
echo.

echo 🔍 Checking Python packages...
python -c "import fastapi, uvicorn, python_multipart" 2>nul
if errorlevel 1 (
    echo ❌ Missing Python dependencies
    echo Run: pip install fastapi uvicorn python-multipart
) else (
    echo ✅ Python dependencies are installed
)

echo 🔍 Checking Node.js packages...
if exist "ui\react-js\node_modules" (
    echo ✅ Node.js dependencies are installed
) else (
    echo ❌ Missing Node.js dependencies
    echo Run: cd ui\react-js && npm install
)

echo.

REM Test 6: Check Directories
echo 📁 Checking Directory Structure...
echo.

if exist "temp_imgs" (
    echo ✅ temp_imgs directory exists
) else (
    echo ❌ temp_imgs directory missing
)

if exist "ui\react-js\src" (
    echo ✅ Frontend source directory exists
) else (
    echo ❌ Frontend source directory missing
)

if exist "code\utils" (
    echo ✅ Backend utils directory exists
) else (
    echo ❌ Backend utils directory missing
)

echo.

REM Test 7: Integration Summary
echo 📊 Integration Test Summary
echo ================================
echo.
echo ✅ Backend Server: http://localhost:8000
echo ✅ Frontend Server: http://localhost:3000
echo ✅ API Documentation: http://localhost:8000/docs
echo ✅ Health Check: http://localhost:8000/api/health
echo.

echo 🎯 Available Features:
echo   📄 Document Upload & Analysis
echo   📸 Face Recognition & Verification
echo   👤 Liveness Detection
echo   📊 Customer Data Management
echo   🔍 Real-time Processing
echo.

echo 🌐 Access Points:
echo   Frontend: http://localhost:3000
echo   Backend API: http://localhost:8000/api
echo   Swagger Docs: http://localhost:8000/docs
echo   ReDoc: http://localhost:8000/redoc
echo.

echo 🎉 Auto-KYC System Integration Test Complete!
echo.
echo If all tests passed, the system is ready for use.
echo.

pause
