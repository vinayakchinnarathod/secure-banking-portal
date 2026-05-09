#!/usr/bin/env python3
"""
Simple Backend Test Script
Tests if the backend can start and respond to basic requests
"""

import sys
import os
import time
import requests
from threading import Thread
import subprocess

def start_backend():
    """Start the backend server"""
    try:
        # Change to the correct directory
        os.chdir("c:\\Users\\VINAYAK CHINNARATHOD\\Documents\\Bank System Website\\auto-kyc")
        
        # Start the backend
        process = subprocess.Popen([
            sys.executable, "main.py"
        ], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        
        # Wait for server to start
        time.sleep(5)
        
        return process
    except Exception as e:
        print(f"Error starting backend: {e}")
        return None

def test_backend():
    """Test backend endpoints"""
    base_url = "http://localhost:8000"
    
    tests = [
        ("Health Check", f"{base_url}/api/health"),
        ("Root", f"{base_url}/"),
        ("Customers", f"{base_url}/api/customers"),
        ("API Docs", f"{base_url}/docs")
    ]
    
    results = []
    
    for test_name, url in tests:
        try:
            response = requests.get(url, timeout=3)
            if response.status_code == 200:
                print(f"✅ {test_name}: Working")
                results.append(True)
            else:
                print(f"❌ {test_name}: Status {response.status_code}")
                results.append(False)
        except Exception as e:
            print(f"❌ {test_name}: Error - {str(e)}")
            results.append(False)
    
    return results

def main():
    """Main test function"""
    print("🔍 Starting Auto-KYC Backend Test")
    print("=" * 50)
    
    # Start backend
    print("🚀 Starting backend server...")
    backend_process = start_backend()
    
    if not backend_process:
        print("❌ Failed to start backend")
        return
    
    # Test endpoints
    print("\n📊 Testing API endpoints...")
    results = test_backend()
    
    # Summary
    passed = sum(results)
    total = len(results)
    
    print(f"\n📊 Test Results: {passed}/{total} passed")
    
    if passed == total:
        print("🎉 All tests passed! Backend is working properly!")
        print(f"🌐 Frontend URL: http://localhost:3000")
        print(f"🌐 Backend API: http://localhost:8000/api")
        print(f"🌐 API Docs: http://localhost:8000/docs")
    else:
        print("⚠️ Some tests failed. Check the backend logs.")
    
    # Stop backend
    try:
        backend_process.terminate()
        backend_process.wait(timeout=5)
        print("\n🛑 Backend stopped")
    except:
        print("\n⚠️ Could not stop backend gracefully")

if __name__ == "__main__":
    main()
