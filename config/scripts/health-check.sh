#!/bin/bash
# n8n Enterprise Health Check Script
# Monitors system health and sends alerts on critical issues

echo "Performing health check on n8n enterprise deployment..."

# Check if all services are running
SERVICES=("n8n-primary" "n8n-webhook" "n8n-worker" "caddy")
for service in "${SERVICES[@]}"; do
    if ! docker ps --filter "name=$service" --format "{{.Names}}" | grep -q "$service"; then
        echo "[ALERT] Service $service is not running!"
    else
        echo "[OK] Service $service is running"
    fi
done

# Check database connectivity
echo "Checking database connectivity..."
if docker exec n8n-primary curl -s -o /dev/null -w "%{http_code}" http://localhost:5678/healthz | grep -q "200"; then
    echo "[OK] Database connection successful"
else
    echo "[ALERT] Database connection failed!"
fi

# Check disk space
df -h | grep "/dev/sda1"
if [ $(df -h | grep "/dev/sda1" | awk '{print $5}' | sed 's/%//g') -gt 80 ]; then
    echo "[ALERT] Disk space usage is high!"
fi

echo "Health check completed"
