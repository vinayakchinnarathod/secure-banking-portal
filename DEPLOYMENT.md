# Secure Banking System - Deployment Guide

## Overview
This guide covers multiple deployment options for the Secure Banking System, which consists of:
- **Frontend**: React.js application
- **Backend**: Java Spring Boot API
- **Auto-KYC**: Python FastAPI service with AI capabilities

## 🐳 Option 1: Docker Deployment (Recommended)

### Prerequisites
- Docker and Docker Compose installed
- Git repository cloned locally

### Quick Start
```bash
# Clone the repository
git clone <your-repo-url>
cd "Bank System Website"

# Build and start all services
docker-compose up -d

# Access the application
# Frontend: http://localhost:3000
# Backend API: http://localhost:8080
# Auto-KYC: http://localhost:8000
# Database: localhost:3306
```

### Docker Services
- **mysql**: MySQL 8.0 database
- **backend**: Java Spring Boot application
- **auto-kyc**: Python FastAPI service
- **frontend**: React application with Nginx

## 🌐 Option 2: Cloud Platform Deployment

### Frontend (Netlify/Vercel)

#### Netlify Deployment
1. Push code to GitHub
2. Connect Netlify to your GitHub repository
3. Set environment variables:
   ```
   REACT_APP_API_URL=https://your-backend-url.com/api
   REACT_APP_KYC_URL=https://your-kyc-service-url.com/api
   ```
4. Deploy automatically on push to main branch

#### Vercel Deployment
1. Install Vercel CLI: `npm i -g vercel`
2. Run: `vercel --prod`
3. Set environment variables in Vercel dashboard

### Backend (Heroku/Railway)

#### Heroku Deployment
1. Create Heroku account and install CLI
2. Login: `heroku login`
3. Create app: `heroku create your-app-name`
4. Set environment variables:
   ```bash
   heroku config:set DATABASE_URL=jdbc:mysql://your-db-url/secure_bank
   heroku config:set DATABASE_USERNAME=your-db-user
   heroku config:set DATABASE_PASSWORD=your-db-pass
   heroku config:set JWT_SECRET=your-jwt-secret
   heroku config:set AUTOKYC_BASE_URL=https://your-kyc-service-url.com/api
   heroku config:set SPRING_PROFILES_ACTIVE=prod
   ```
5. Deploy: `git push heroku main`

#### Railway Deployment
1. Connect Railway to GitHub
2. Select repository and configure service
3. Set environment variables in Railway dashboard
4. Railway will auto-deploy on push

### Auto-KYC Service (Render/Railway)

#### Render Deployment
1. Create Render account
2. Connect GitHub repository
3. Select "Web Service"
4. Set build command: `pip install -r requirements.txt`
5. Set start command: `uvicorn api_simple:app --host 0.0.0.0 --port $PORT`
6. Set environment variables as needed

## 🔧 Environment Variables

### Frontend (.env.production)
```bash
REACT_APP_API_URL=https://your-backend-url.com/api
REACT_APP_KYC_URL=https://your-kyc-service-url.com/api
GENERATE_SOURCEMAP=false
```

### Backend (Production)
```bash
DATABASE_URL=jdbc:mysql://your-db-host:3306/secure_bank
DATABASE_USERNAME=your-db-user
DATABASE_PASSWORD=your-db-pass
JWT_SECRET=your-secure-jwt-secret
AUTOKYC_BASE_URL=https://your-kyc-service-url.com/api
SPRING_PROFILES_ACTIVE=prod
```

### Auto-KYC Service
```bash
AZURE_COGNITIVE_SERVICES_KEY=your-azure-key
AZURE_COGNITIVE_SERVICES_ENDPOINT=your-azure-endpoint
```

## 📊 Database Setup

### MySQL Production
```sql
-- Create database
CREATE DATABASE secure_bank;

-- Create user (optional)
CREATE USER 'bankuser'@'%' IDENTIFIED BY 'strong_password';
GRANT ALL PRIVILEGES ON secure_bank.* TO 'bankuser'@'%';
FLUSH PRIVILEGES;

-- Import schema
mysql -u root -p secure_bank < mysql-setup.sql
```

### Cloud Database Options
- **PlanetScale**: MySQL-compatible serverless
- **AWS RDS**: Managed MySQL instances
- **Railway**: Built-in PostgreSQL/MySQL
- **Heroku Postgres**: PostgreSQL alternative

## 🔒 Security Considerations

1. **Environment Variables**: Never commit secrets to git
2. **HTTPS**: Ensure all services use SSL/TLS
3. **CORS**: Configure proper allowed origins
4. **Database**: Use strong passwords and limit access
5. **JWT**: Use secure, random secret keys
6. **File Upload**: Validate file types and sizes

## 🚀 Deployment Checklist

### Pre-Deployment
- [ ] Update all hardcoded URLs to use environment variables
- [ ] Test locally with production configuration
- [ ] Set up production database
- [ ] Configure SSL certificates
- [ ] Set up monitoring and logging

### Post-Deployment
- [ ] Verify all services are running
- [ ] Test API endpoints
- [ ] Check file upload functionality
- [ ] Verify KYC AI service integration
- [ ] Set up backup procedures
- [ ] Configure domain names and DNS

## 🐛 Troubleshooting

### Common Issues

#### CORS Errors
```bash
# Check CORS configuration
curl -H "Origin: https://your-frontend.com" \
     -H "Access-Control-Request-Method: POST" \
     -H "Access-Control-Request-Headers: X-Requested-With" \
     -X OPTIONS https://your-backend.com/api/auth/login
```

#### Database Connection
```bash
# Test database connection
mysql -h your-db-host -u your-user -p secure_bank
```

#### Service Health Checks
```bash
# Backend health
curl https://your-backend.com/api/health

# Auto-KYC health
curl https://your-kyc-service.com/api/health
```

## 📈 Monitoring

### Recommended Tools
- **Uptime monitoring**: UptimeRobot, Pingdom
- **Error tracking**: Sentry, Bugsnag
- **Performance**: New Relic, DataDog
- **Logs**: Papertrail, Logtail

### Health Endpoints
- Backend: `/api/health`
- Auto-KYC: `/api/health`
- Frontend: Check for successful page load

## 🔄 CI/CD Pipeline

### GitHub Actions Example
```yaml
name: Deploy to Production
on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Deploy Backend
        run: |
          # Deploy backend to Railway/Heroku
      - name: Deploy Frontend
        run: |
          # Deploy frontend to Netlify/Vercel
      - name: Deploy Auto-KYC
        run: |
          # Deploy Python service to Render
```

## 💰 Cost Optimization

### Free Tier Usage
- **Frontend**: Netlify/Vercel (free)
- **Backend**: Railway ($5/month after free tier)
- **Database**: PlanetScale (free tier available)
- **Auto-KYC**: Render (free tier available)

### Scaling Tips
1. Use serverless for frontend
2. Start with smallest database tier
3. Monitor usage and scale as needed
4. Use CDN for static assets

## 📞 Support

For deployment issues:
1. Check logs for each service
2. Verify environment variables
3. Test individual services
4. Check network connectivity
5. Review this documentation

---

**Note**: This deployment guide assumes you have the necessary cloud accounts and basic understanding of web deployment concepts.
