#!/bin/bash

# Secure Banking System Deployment Script
# This script helps deploy the application to various platforms

set -e

echo "🚀 Secure Banking System Deployment Script"
echo "=========================================="

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to deploy to Docker
deploy_docker() {
    echo "🐳 Deploying with Docker..."
    
    if ! command_exists docker; then
        echo "❌ Docker is not installed. Please install Docker first."
        exit 1
    fi
    
    if ! command_exists docker-compose; then
        echo "❌ Docker Compose is not installed. Please install Docker Compose first."
        exit 1
    fi
    
    echo "📦 Building and starting services..."
    docker-compose up -d --build
    
    echo "✅ Docker deployment complete!"
    echo "🌐 Frontend: http://localhost:3000"
    echo "🔧 Backend: http://localhost:8080"
    echo "🤖 Auto-KYC: http://localhost:8000"
}

# Function to deploy frontend to Netlify
deploy_frontend_netlify() {
    echo "🌐 Deploying frontend to Netlify..."
    
    if ! command_exists netlify; then
        echo "❌ Netlify CLI is not installed. Installing..."
        npm install -g netlify-cli
    fi
    
    echo "📦 Building frontend..."
    cd frontend
    npm install
    npm run build
    
    echo "🚀 Deploying to Netlify..."
    netlify deploy --prod --dir=build
    
    cd ..
    echo "✅ Frontend deployed to Netlify!"
}

# Function to deploy backend to Heroku
deploy_backend_heroku() {
    echo "🔧 Deploying backend to Heroku..."
    
    if ! command_exists heroku; then
        echo "❌ Heroku CLI is not installed. Please install it first."
        exit 1
    fi
    
    echo "📦 Building backend..."
    cd backend
    mvn clean package -DskipTests
    
    echo "🚀 Deploying to Heroku..."
    heroku deploy:jar target/secure-bank-0.0.1-SNAPSHOT.jar
    
    cd ..
    echo "✅ Backend deployed to Heroku!"
}

# Function to deploy Auto-KYC to Render
deploy_kyc_render() {
    echo "🤖 Deploying Auto-KYC to Render..."
    echo "📝 Please manually deploy the Auto-KYC service to Render:"
    echo "1. Go to https://render.com"
    echo "2. Connect your GitHub repository"
    echo "3. Select the auto-kyc folder"
    echo "4. Set build command: pip install -r requirements.txt"
    echo "5. Set start command: uvicorn api_simple:app --host 0.0.0.0 --port \$PORT"
    echo "6. Configure environment variables"
}

# Function to setup environment variables
setup_env() {
    echo "⚙️ Setting up environment variables..."
    
    # Frontend .env.production
    if [ ! -f "frontend/.env.production" ]; then
        echo "Creating frontend .env.production..."
        cat > frontend/.env.production << EOF
REACT_APP_API_URL=https://your-backend-url.com/api
REACT_APP_KYC_URL=https://your-kyc-service-url.com/api
GENERATE_SOURCEMAP=false
EOF
        echo "✅ Created frontend/.env.production"
    fi
    
    echo "📝 Please update the following environment variables:"
    echo "- Frontend: frontend/.env.production"
    echo "- Backend: Set in your cloud platform dashboard"
    echo "- Auto-KYC: Set in your cloud platform dashboard"
}

# Function to show help
show_help() {
    echo "Usage: $0 [COMMAND]"
    echo ""
    echo "Commands:"
    echo "  docker          Deploy all services using Docker"
    echo "  frontend        Deploy frontend only"
    echo "  backend         Deploy backend only"
    echo "  kyc             Deploy Auto-KYC service only"
    echo "  env             Setup environment variables"
    echo "  help            Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 docker                    # Deploy everything with Docker"
    echo "  $0 frontend                  # Deploy frontend to Netlify"
    echo "  $0 backend                   # Deploy backend to Heroku"
}

# Main script logic
case "${1:-}" in
    "docker")
        deploy_docker
        ;;
    "frontend")
        deploy_frontend_netlify
        ;;
    "backend")
        deploy_backend_heroku
        ;;
    "kyc")
        deploy_kyc_render
        ;;
    "env")
        setup_env
        ;;
    "help"|"--help"|"-h")
        show_help
        ;;
    "")
        echo "❌ No command specified. Use 'help' for usage information."
        show_help
        exit 1
        ;;
    *)
        echo "❌ Unknown command: $1"
        show_help
        exit 1
        ;;
esac

echo ""
echo "🎉 Deployment process completed!"
echo "📖 For detailed deployment instructions, see DEPLOYMENT.md"
