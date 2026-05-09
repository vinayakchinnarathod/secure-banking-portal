# Multi-stage build for Secure Banking System
FROM node:18-alpine AS frontend-builder

WORKDIR /app/frontend
COPY frontend/package*.json ./
RUN npm ci --only=production

COPY frontend/ ./
RUN npm run build

# Java Backend
FROM maven:3.9-openjdk-17 AS backend-builder

WORKDIR /app/backend
COPY backend/pom.xml ./
RUN mvn dependency:go-offline

COPY backend/src ./src
RUN mvn clean package -DskipTests

# Python Auto-KYC
FROM python:3.11-slim AS kyc-builder

WORKDIR /app/auto-kyc
COPY auto-kyc/requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY auto-kyc/ ./

# Final production image
FROM nginx:alpine

# Copy built frontend
COPY --from=frontend-builder /app/frontend/build /usr/share/nginx/html

# Copy backend JAR
COPY --from=backend-builder /app/backend/target/*.jar /app/backend.jar

# Copy Python service
COPY --from=kyc-builder /app/auto-kyc /app/auto-kyc

# Install Java and Python runtime
RUN apk add --no-cache openjdk17-jre python3

# Copy startup scripts
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

# Copy nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80 8080 8000

CMD ["/docker-entrypoint.sh"]
