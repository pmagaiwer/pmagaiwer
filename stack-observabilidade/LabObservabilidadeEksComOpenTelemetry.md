# 🧪 Lab de Observabilidade com OpenTelemetry no EKS

Este repositório é um **exemplo completo e didático** para estudar observabilidade moderna usando **OpenTelemetry + Prometheus + Grafana + Tempo**, com foco prático em **SLIs, SLOs e alertas bem desenhados**.

---

## 📁 Estrutura do Repositório

```
observability-lab-eks/
├── README.md
├── eks/
│   └── cluster.yaml
├── app/
│   ├── Dockerfile
│   ├── requirements.txt
│   └── app.py
├── otel/
│   └── otel-collector.yaml
├── prometheus/
│   ├── rules-slo.yaml
│   └── alerts.yaml
├── grafana/
│   ├── dashboards/
│   │   ├── app-red-metrics.json
│   │   ├── kubernetes-overview.json
│   │   └── slo-overview.json
│   └── datasources.yaml
└── helm-install.sh
```

---

## 🚀 Aplicação Exemplo (Python + Flask)

A aplicação já nasce **instrumentada com OpenTelemetry**.

### app/app.py

```python
from flask import Flask
import random, time
from opentelemetry.instrumentation.flask import FlaskInstrumentor
from opentelemetry import trace

app = Flask(__name__)
FlaskInstrumentor().instrument_app(app)

@app.route("/")
def hello():
    time.sleep(random.uniform(0.1, 0.8))
    if random.random() < 0.1:
        return "error", 500
    return "hello world"

app.run(host="0.0.0.0", port=8080)
```

👉 Essa app gera **latência variável, erros reais e traces distribuídos**.

---

## 🔭 OpenTelemetry Collector (DaemonSet)

### otel/otel-collector.yaml

```yaml
mode: daemonset
receivers:
  otlp:
    protocols:
      grpc:
      http:
processors:
  batch: {}
exporters:
  prometheus:
    endpoint: "0.0.0.0:8889"
  otlp:
    endpoint: tempo.monitoring:4317
service:
  pipelines:
    metrics:
      receivers: [otlp]
      processors: [batch]
      exporters: [prometheus]
    traces:
      receivers: [otlp]
      processors: [batch]
      exporters: [otlp]
```

📌 **Ponto-chave**: aqui você controla sampling, enrich, fan-out.

---

## 📊 Dashboards Grafana (prontos)

### 1️⃣ RED Metrics – Aplicação

**Rate**

```promql
sum(rate(http_server_requests_total[5m]))
```

**Errors**

```promql
sum(rate(http_server_requests_total{status=~"5.."}[5m]))
```

**Duration (p95)**

```promql
histogram_quantile(0.95, rate(http_server_request_duration_seconds_bucket[5m]))
```

---

### 2️⃣ Kubernetes Overview

* CPU por pod
* Memory por namespace
* Restarts
* Latência de API Server

---

### 3️⃣ SLO Overview Dashboard

* Burn Rate (1h / 6h)
* Error Budget restante
* Disponibilidade mensal

---

## 🎯 SLIs e SLOs (reais e usados em produção)

### 🎯 SLI – Disponibilidade

```promql
1 - (
  sum(rate(http_server_requests_total{status=~"5.."}[5m]))
  /
  sum(rate(http_server_requests_total[5m]))
)
```

### 🎯 SLO

* **99.9% de sucesso em 30 dias**
* Error Budget: **0.1%**

---

### 🔥 Burn Rate

```promql
(
  sum(rate(http_server_requests_total{status=~"5.."}[5m]))
  /
  sum(rate(http_server_requests_total[5m]))
) / 0.001
```

---

## 🚨 Alertas bem feitos (sem ruído)

### 🚨 Alert: SLO Burn Rate Alto (rápido)

```yaml
groups:
- name: slo-alerts
  rules:
  - alert: HighBurnRate
    expr: slo_burn_rate_5m > 14
    for: 5m
    labels:
      severity: critical
    annotations:
      summary: "SLO queimando rápido"
```

### 🚨 Alert: Erro Sustentado

```yaml
- alert: HighErrorRate
  expr: |
    sum(rate(http_server_requests_total{status=~"5.."}[10m]))
    /
    sum(rate(http_server_requests_total[10m])) > 0.02
  for: 10m
  labels:
    severity: warning
```

📌 **Por que isso é bom?**

* Janela de tempo
* Baseado em impacto real
* Pouco ruído

---

## 🧠 O que você aprende com esse lab

✔ OpenTelemetry de verdade (SDK + Collector)
✔ Métricas Kubernetes + app
✔ Tracing distribuído
✔ SLIs / SLOs acionáveis
✔ Alertas orientados a erro de usuário

---

## 🧭 Próximos upgrades

* Adicionar Loki (logs correlacionados)
* Adicionar exemplars (trace_id nas métricas)
* Canary + SLO por versão
* Chaos Engineering

---

## ✅ Conclusão

Este repo simula **exatamente o que empresas maduras usam**.

Se você domina isso, você:

* Entende produção
* Reduz MTTR
* Cria alertas confiáveis

👉 Próximo passo possível: **Datadog vs OpenTelemetry**, **SLO multi-tenant**, ou **Golden Signals em larga escala**.
