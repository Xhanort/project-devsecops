# Logging

Implementasi centralized logging menggunakan:

- Fluent Bit
- Elasticsearch
- Kibana

Log dari seluruh pod Kubernetes dikumpulkan secara otomatis sehingga developer tidak perlu melakukan `kubectl logs` ke masing-masing pod.
