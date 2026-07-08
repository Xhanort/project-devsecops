# DevSecOps & Observability on Kubernetes


Repository ini berisi usulan implementasi **DevSecOps** dan **Observability** pada lingkungan Kubernetes.

Studi kasus ini menggunakan infrastruktur yang telah tersedia:

- Git Repository
- Jenkins
- Kubernetes Cluster

Tujuan implementasi adalah meningkatkan keamanan aplikasi sejak tahap development, mengotomatisasi proses deployment, serta menyediakan monitoring, logging, dan tracing agar sistem lebih mudah dipantau dan ditroubleshoot.

---

# Architecture


````text
                       Developer
                            │
                            ▼
                    Git Repository
                            │
                            ▼
                     Jenkins Pipeline
                            │
      ┌────────────────────────────────────┐
      │          Security Stage            │
      │────────────────────────────────────│
      │ 1. SAST (SonarQube / Semgrep)      │
      │ 2. Secret Scan (Gitleaks)          │
      │ 3. Dependency Scan (Trivy)         │
      │ 4. Container Image Scan (Trivy)    │
      └────────────────────────────────────┘
                            │
                            ▼
                     Docker Build
                            │
                            ▼
                  Container Registry
                            │
                            ▼
                    Kubernetes Cluster
                            │
            ┌───────────────┼───────────────┐
            ▼               ▼               ▼
      Monitoring         Logging         Tracing
     (Prometheus)      (EFK Stack)      (Jaeger)
            │
            ▼
      Grafana Dashboard
            │
            ▼
        Alertmanager
            │
            ▼
   Email / Slack / Telegram````
````
---

# DevSecOps Workflow

1. Developer melakukan push code ke Git Repository.
2. Jenkins menjalankan pipeline CI/CD.
3. Source code diperiksa menggunakan SAST.
4. Repository diperiksa menggunakan Secret Scan.
5. Dependency diperiksa menggunakan Trivy.
6. Docker image dibangun.
7. Docker image diperiksa kembali menggunakan Trivy.
8. Image dikirim ke Container Registry.
9. Deployment ke Kubernetes dilakukan jika seluruh tahapan berhasil.
10. Aplikasi dimonitor menggunakan Prometheus, Grafana, dan Alertmanager.

---

# Repository Structure

```
.
├── jenkins/
├── sast/
├── secret-scan/
├── dependency-scan/
├── kubernetes/
├── monitoring/
├── logging/
├── tracing/
└── README.md
```

---

# DevSecOps Components

| Component | Tool | Function |
|-----------|------|----------|
| CI/CD | Jenkins | Build & Deploy |
| Source Code Analysis | SonarQube / Semgrep | Static Application Security Testing |
| Secret Detection | Gitleaks | Detect Hardcoded Credential |
| Dependency Scan | Trivy | Detect Library Vulnerability |
| Container Scan | Trivy | Scan Docker Image |
| Secret Management | Kubernetes Secret | Secure Credential |
| Configuration | ConfigMap | Application Configuration |

---

# Observability Components

| Component | Tool | Function |
|----------|------|----------|
| Metrics | Prometheus | Collect Metrics |
| Dashboard | Grafana | Visualization |
| Alerting | Alertmanager | Notification |
| Logging | Fluent Bit + Elasticsearch + Kibana | Centralized Logging |
| Tracing | Jaeger | Distributed Tracing |

---

# Security Pipeline

```
Git Push

↓

Checkout

↓

SAST

↓

Secret Scan

↓

Dependency Scan

↓

Docker Build

↓

Image Scan

↓

Deploy

↓

Monitoring
```

---

# Monitoring Flow

```
Application

↓

Prometheus

↓

Grafana

↓

Alertmanager

↓

Email / Telegram / Slack
```

---

# Logging Flow

```
Application

↓

Fluent Bit

↓

Elasticsearch

↓

Kibana
```

---

# Tracing Flow

```
Client

↓

API Gateway

↓

Service A

↓

Service B

↓

Database

↓

Jaeger
```

---

# Benefits

- Security diterapkan sejak awal proses development (Shift Left Security).
- Credential tidak tersimpan di repository.
- Library yang rentan dapat terdeteksi sebelum deployment.
- Monitoring aplikasi dilakukan secara real-time.
- Centralized logging mempercepat troubleshooting.
- Distributed tracing mempermudah analisis performa antar service.
- Deployment menjadi lebih aman dan otomatis.

---


