#!/bin/bash
# Download PostgreSQL CA certificate
curl -o config/certs/ca-certificate.crt https://truststore.pki.rds.amazonaws.com/global/global-bundle.pem
echo "CA certificate downloaded successfully"
