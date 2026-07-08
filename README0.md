# DevSecOps & Observability Kubernetes

## Studi Kasus

Implementasi DevSecOps Pipeline dan Observability pada Kubernetes menggunakan:

- Git
- Jenkins
- Kubernetes
- SonarQube
- Gitleaks
- Trivy
- Prometheus
- Grafana
- Alertmanager
- EFK Stack
- Jaeger

---

## DevSecOps Flow

Developer

↓

Git Repository

↓

Jenkins

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

Push Registry

↓

Deploy Kubernetes

↓

Monitoring

---

## Repository Structure

jenkins/

kubernetes/

monitoring/

logging/

tracing/

---

## Security Tools

| Tool | Function |
|------|----------|
| SonarQube | Static Code Analysis |
| Gitleaks | Secret Detection |
| Trivy | Dependency & Image Scan |

---

## Observability

Prometheus

Grafana

Alertmanager

EFK

Jaeger
