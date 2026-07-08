# DevSecOps & Observability on Kubernetes

## Study Case

Repository ini berisi usulan implementasi DevSecOps dan Observability pada lingkungan Kubernetes dengan studi kasus perusahaan yang telah memiliki:

- Git Repository
- Jenkins
- Kubernetes Cluster

---

# Architecture

Developer

↓

Git Repository

↓

Jenkins CI/CD

↓

SAST Scan

↓

Secret Scan

↓

Dependency Scan

↓

Docker Build

↓

Image Scan

↓

Container Registry

↓

Kubernetes

↓

Monitoring

↓

Alerting

---

# DevSecOps

## Static Application Security Testing

Tool

- SonarQube
- Semgrep

Fungsi

- SQL Injection
- XSS
- Code Smell
- Hardcoded Secret

---

## Secret Detection

Tool

- Gitleaks

Fungsi

Mendeteksi credential yang tidak sengaja di-push ke repository.

---

## Dependency Scan

Tool

- Trivy

Fungsi

Mendeteksi vulnerability pada package dan Docker image.

---

## Secret Management

Menggunakan

- Kubernetes Secret
- ConfigMap
- RBAC

---

# Observability

Monitoring

- Prometheus
- Grafana
- Alertmanager

Logging

- Fluent Bit
- Elasticsearch
- Kibana

Tracing

- Jaeger

---

# Repository Structure

jenkins/

sast/

secret-scan/

dependency-scan/

kubernetes/

monitoring/

logging/

tracing/

---

# Author

Faldo Satria
Junior DevOps Engineer
