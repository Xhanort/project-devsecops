
## Soal 1: DevSecOps (Git, Jenkins, Kubernetes)

### 1. Usulan Solusi DevSecOps
Menerapkan konsep **Shift-Left Security** dengan membangun **Automated Security Pipeline** di Jenkins. Setiap kode yang di-*push* ke Git wajib melewati serangkaian *automated security gates* sebelum dideploy ke Kubernetes.

### 2. Static Application Security Testing (SAST)
* **Tools:** SonarQube / Semgrep.
* **Implementasi:** Scan *source code* pasif di pipeline Jenkins untuk mendeteksi *code quality*, *bug*, dan celah keamanan (SQLi, XSS). Pasang *Quality Gate* agar build otomatis gagal jika ditemukan kerentanan tingkat *High*.

### 3. Secret Scanning
* **Tools:** TruffleHog / Gitleaks.
* **Implementasi:** Melakukan pemindaian riwayat *commit* di awal pipeline untuk mendeteksi adanya *hardcoded* password, API key, atau token sensitif yang tidak sengaja ter-push.

### 4. Patch Management & Software Composition Analysis (SCA)
* **Tools:** Trivy / OWASP Dependency-Check.
* **Implementasi:** Memeriksa kerentanan (CVE) pada *third-party libraries* (dependencies) dan melakukan scan pada *container image* (Docker image) hasil build sebelum di-push ke registry.

### 5. Monitoring Aktif & Pasif
* **Aktif (Real-time):** Integrasi Jenkins & SonarQube ke **Slack/Telegram** via Webhook untuk notifikasi instan jika pipeline gagal.
* **Pasif (Dashboard):** Menggunakan dashboard **SonarQube** atau **DefectDojo** untuk memantau tren keamanan aplikasi secara berkala.

### 6. Manajemen Secret & Config
* **Config Biasa:** Menggunakan Kubernetes **ConfigMap** (terpisah dari kode).
* **Secret/Kredensial:** Disimpan di **HashiCorp Vault**. Integrasi ke Kubernetes menggunakan **External Secrets Operator (ESO)** untuk menyuntikkan secret secara aman dan dinamis tanpa mengekspos *value* asli ke developer.

---

## Soal 2: Observability (Log, Metric, Trace)

### 1. Monitoring Aplikasi Aktif & Pasif
* **Tools:** Prometheus + Grafana + Alertmanager + Uptime Kuma.
* **Aktif (Alerting):** Uptime Kuma/Blackbox Exporter melakukan HTTP probe ke endpoint `/healthz`. Jika aplikasi *down* atau pod berstatus `CrashLoopBackOff`, Alertmanager otomatis mengirim alert ke Slack/Telegram.
* **Pasif (NOC Dashboard):** Membuat dashboard visualisasi *cluster health* di Grafana untuk monitoring harian.

### 2. Pengelolaan Log Terpusat (Solusi Developer)
* **Stack:** LGTM Stack (Grafana Loki) atau EFK Stack (Elasticsearch, Fluent-Bit, Kibana).
* **Implementasi:** Agen (**Fluent-Bit/Promtail**) mengumpulkan log dari seluruh node Kubernetes ke penyimpanan terpusat (**Loki/Elasticsearch**). Developer diberikan akses berbasis **RBAC** ke web UI Grafana/Kibana untuk *troubleshooting* log, sehingga tidak perlu akses langsung ke CLI Kubernetes (`kubectl logs`).

### 3. Pengukuran Performa Aplikasi & Database
* **Metrik (Database):** Menggunakan Prometheus **DB Exporter** (misal: *PostgreSQL Exporter*) untuk memantau utilitas CPU/Memory, IOPS, dan jumlah koneksi aktif database.
* **Tracing (Aplikasi):** Implementasi **OpenTelemetry** dan **Grafana Tempo/Jaeger** untuk *Distributed Tracing*. Menggunakan *Trace ID* untuk melacak *timeline request* aplikasi secara visual guna menemukan *bottleneck* (misal: query SQL yang lambat).
