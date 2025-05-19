# n8n Enterprise Deployment Framework

## Strategic Architecture Overview

This repository implements a production-grade, distributed n8n workflow automation platform with:

- **Multi-instance Architecture**: Dedicated webhook processor, workers, and primary instance
- **Queue-based Execution**: High-throughput workflow processing with Valkey/Redis backend
- **Enterprise Database**: PostgreSQL for data persistence and integrity
- **Zero-touch SSL**: Automatic certificate management with Caddy
- **Infrastructure-as-Code**: Complete deployment via version-controlled configuration

## Deployment Architecture

```
n8n Enterprise Deployment
├── Primary Instance (UI, API, management)
├── Webhook Instance (dedicated trigger processing)
├── Worker Instance (dedicated workflow execution)
├── Caddy Reverse Proxy (SSL termination, security headers)
└── Managed Database Services
    ├── PostgreSQL (workflow data)
    └── Valkey/Redis (queue management)
```

## Deployment Instructions

1. Clone this repository to your VPS:
   ```
   git clone https://github.com/yourusername/n8n-enterprise-deployment.git
   cd n8n-enterprise-deployment
   ```

2. Download the PostgreSQL certificate:
   ```
   ./config/scripts/download-cert.sh
   ```

3. Validate configuration:
   ```
   docker compose config
   ```

4. Deploy the infrastructure:
   ```
   docker compose up -d
   ```

5. Verify deployment:
   ```
   docker compose ps
   ```

## Maintenance Operations

### Updating n8n

```bash
docker compose pull
docker compose up -d
```

### Backup and Restore

Backup:
```bash
tar -czf n8n-backup-$(date +%Y%m%d).tar.gz ./data
```

Restore:
```bash
tar -xzf n8n-backup-YYYYMMDD.tar.gz
```

### Monitoring

Execute the health check script:
```bash
./config/scripts/health-check.sh
```

## Security Considerations

This deployment implements enterprise-grade security measures:

- Strict TLS configuration (TLS 1.3 only)
- Comprehensive security headers
- Private network isolation
- Principle of least privilege
