# DevSecOps Implementation Guide (Git, Jenkins, Kubernetes)

Catatan solusi taktis untuk mengintegrasikan aspek keamanan ke dalam CI/CD Pipeline (*Shift-Left Security*) menggunakan fasilitas Git, Jenkins, dan Kubernetes.

## Daftar Isi
- [1. Usulan Solusi DevSecOps Pipeline](#1-usulan-solusi-devsecops-pipeline)
- [2. Static Application Security Testing (SAST)](#2-static-application-security-testing-sast)
- [3. Secret Scanning (Credential Check)](#3-secret-scanning-credential-check)
- [4. SCA & Patch Management](#4-sca--patch-management)
- [5. Sistem Monitoring Aktif & Pasif](#5-sistem-monitoring-aktif--pasif)
- [6. Manajemen Secret & Konfigurasi](#6-manajemen-secret--konfigurasi)

---

## 1. Usulan Solusi DevSecOps Pipeline

Menerapkan konsep **Shift-Left Security** dengan membangun **Automated Security Pipeline** di Jenkins. Setiap kode yang di-*push* ke Git wajib melewati serangkaian *automated security gates* sebelum diizinkan *deploy* ke kluster Kubernetes.

## 2. Static Application Security Testing (SAST)
Pengecekan keamanan kode sebelum masuk production (Static Test).

Tools: SonarQube / Semgrep.

Implementasi: Scan source code secara pasif di dalam pipeline Jenkins tanpa menjalankan aplikasi. Bertujuan mendeteksi bad practices, bug, dan celah keamanan (seperti SQL Injection atau XSS).

Gate: Pasang Quality Gate di Jenkins agar proses build otomatis gagal jika ditemukan kerentanan tingkat High/Critical.

Analogi: Memeriksa teks naskah sebelum panggung sandiwara dimulai.

## 3. Secret Scanning
Memastikan kode tidak mengandung informasi kredensial.

Tools: TruffleHog / Gitleaks.

Implementasi: Dijalankan di tahap awal pipeline Jenkins untuk memindai riwayat commit Git. Tool akan mencari string yang polanya mirip password, API key, atau token sensitif menggunakan regex dan entropi. Jika terdeteksi, pipeline langsung dihentikan sebelum bocor ke repository.

## 4. SCA & Patch Management
Cara cek library pihak ketiga yang digunakan memiliki kerentanan.

Tools: Trivy / OWASP Dependency-Check.

Implementasi:

Cek Library (SCA): Memeriksa manifest file (package.json, pom.xml, requirements.txt) terhadap database kerentanan global (CVE).

Cek Container: Trivy digunakan untuk men-scan base image atau Docker image hasil build Jenkins sebelum di-push ke registry.

## 5. Sistem Monitoring Aktif & Pasif
Bagaimana tim/pegawai dapat memonitor kondisi keamanan ini.

Aktif (Real-time Alerting): Mengintegrasikan Jenkins dan SonarQube ke Slack/Telegram via Webhook. Jika ada pipeline gagal karena isu keamanan, tim langsung mendapat notifikasi instan.

Pasif (Dashboarding): Menyediakan dashboard terpusat seperti SonarQube Dashboard atau DefectDojo untuk memantau grafik tren keamanan seluruh aplikasi secara berkala.

## 6. Manajemen Secret & Konfigurasi
Pemisahan data sensitif dan konfigurasi aplikasi yang baik.

Konfigurasi Biasa (Non-Sensitif): Menggunakan Kubernetes ConfigMap yang dipisah dari source code utama.

Data Sensitif (Secret): Disimpan dengan aman di HashiCorp Vault. Di sisi Kubernetes, dipasang External Secrets Operator (ESO) untuk menarik data dari Vault dan mengubahnya menjadi Kubernetes Secret secara dinamis. Developer tidak perlu mengetahui value asli kredensial.


```text
Git Push ──> Secret Scan ──> SAST (Static) ──> SCA (Library/Image) ──> Deploy K8s


## Contoh Implementasi Tahap Automated Scan (GitHub Actions / Jenkins)
YAML

- name: Run Trivy Vulnerability Scanner
  uses: aquasecurity/trivy-action@master
  with:
    image-ref: 'your-registry/app:latest'
    format: 'table'
    exit-code: '1' # Menggagalkan pipeline jika ada celah berbahaya
    severity: 'CRITICAL,HIGH'
