#!/bin/bash
set -e

echo ">> Scanning filesystem dependencies..."
trivy fs . --severity CRITICAL,HIGH --exit-code 1 --format table

echo ">> Scanning container image..."
trivy image backend:latest --severity CRITICAL,HIGH --exit-code 1 --format table
