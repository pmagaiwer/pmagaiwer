# Stack Moderna de Observabilidade com OpenTelemetry + Kubernetes (EKS)

Esta imagem representa uma stack moderna de observabilidade, alinhada com OpenTelemetry e Kubernetes (EKS). Abaixo, explico em 3 camadas, com visão didática e SRE/Plataforma:

## 📐 O papel de cada componente da stack
## 🔭 Onde o OpenTelemetry entra (e por que ele é o coração disso tudo)
## 🧪 Como montar um laboratório prático no EKS para estudos

---

## 1️⃣ Observability Pillars (os pilares)

Os 3 sinais clássicos de observabilidade:

- **Logs**
  - Eventos textuais
  - Erros, warnings, mensagens de negócio
  - Alta cardinalidade, pouco estruturados
- **Metrics**
  - Valores numéricos ao longo do tempo
  - CPU, memória, latência, taxa de erro, QPS
  - Base para SLIs, SLOs e alertas
- **Traces**
  - Caminho completo de uma requisição
  - Mostra onde está lento ou quebrando
  - Essencial em microsserviços

> **Importante:** Observabilidade ≠ monitoramento. Observabilidade te ajuda a entender o porquê, não só saber que quebrou.

---

## 2️⃣ Application (sua aplicação)

É onde tudo começa. Ela:
- Gera logs
- Emite métricas
- Cria spans de trace

❌ Sem instrumentação → nada chega na stack
✅ Com instrumentação correta → visibilidade total

---

## 3️⃣ Instrumentation Patterns

Aqui entra o **OpenTelemetry (OTel)** 💙

- Padrão aberto de instrumentação, neutro de vendor
- Instrumentação automática ou manual
- Coleta logs, métricas e traces
- Envia tudo para qualquer backend

**Componentes principais:**
- SDK (dentro da aplicação)
- Collector (sidecar ou daemonset)

**Papel real:** Separar instrumentação de armazenamento.

**Benefícios:**
- Liberdade de trocar Grafana, Datadog, NewRelic, etc
- Padronização
- Menos lock-in

---

## 4️⃣ OpenTelemetry Collector (o “hub” da stack)

Bloco central da stack:
- Recebe dados (OTLP, Prometheus, logs)
- Processa (batch, sampling, enrich)
- Exporta para múltiplos destinos

No EKS:
- DaemonSet → coleta de todos os nodes
- Deployment → coleta centralizada

**Exemplo de pipelines:**
- Metrics → Prometheus
- Traces  → Jaeger / Tempo
- Logs    → Loki

---

## 5️⃣ Prometheus (Metrics)

- Coleta métricas via scrape
- Armazena séries temporais
- Alimenta alertas e dashboards

No Kubernetes:
- Scrape de pods, nodes, services
- Métricas do kubelet, cAdvisor, API Server

> Ele não instrumenta, só coleta. OTel pode expor métricas no formato Prometheus.

---

## 6️⃣ Grafana (Visualização)

- Dashboards
- Exploração de métricas, logs e traces
- Correlação entre sinais

Normalmente conectado a:
- Prometheus (metrics)
- Loki (logs)
- Tempo / Jaeger (traces)

> Aqui você consome a observabilidade.

---

## 7️⃣ Onde cada ferramenta entra (resumo rápido)

| Camada         | Ferramenta           | Papel         |
|----------------|----------------------|---------------|
| Aplicação      | SDK OpenTelemetry    | Instrumenta   |
| Coleta         | OTel Collector       | Centraliza    |
| Métricas       | Prometheus           | Armazena      |
| Logs           | Loki / stdout        | Armazena      |
| Traces         | Tempo / Jaeger       | Armazena      |
| Visualização   | Grafana              | Analisa       |

---

## 8️⃣ Como montar um laboratório EKS (hands-on)

**Objetivo do lab:** Ver métricas, logs e traces de uma app rodando no EKS usando OpenTelemetry

**Arquitetura do lab:**
```
EKS
 ├─ App (instrumentada com OTel)
 ├─ OTel Collector (DaemonSet)
 ├─ Prometheus
 ├─ Grafana
 └─ Tempo ou Jaeger
```

### Passo 1️⃣ – Criar o EKS
- eksctl
- Terraform
- EKS Auto Mode

### Passo 2️⃣ – Instalar stack via Helm
```sh
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts
helm repo add open-telemetry https://open-telemetry.github.io/opentelemetry-helm-charts
```
Instale:
- kube-prometheus-stack
- grafana
- otel-collector

### Passo 3️⃣ – Deploy do OpenTelemetry Collector
Rodar como DaemonSet:
```yaml
mode: daemonset
receivers:
  otlp:
    protocols:
      grpc:
      http:
exporters:
  prometheus:
    endpoint: "0.0.0.0:8889"
  otlp:
    endpoint: tempo:4317
```

### Passo 4️⃣ – Aplicação instrumentada
Exemplo (Python):
```python
from opentelemetry import trace
from opentelemetry.instrumentation.flask import FlaskInstrumentor
```
Ou usar auto-instrumentação:
```sh
opentelemetry-instrument python app.py
```

### Passo 5️⃣ – Visualizar no Grafana
Você verá:
- Métricas RED (Rate, Errors, Duration)
- Traces com waterfall
- Logs correlacionados com trace_id

💡 Aqui você aprende debug real de produção.

---

## 9️⃣ O que estudar em ordem (recomendado)
1. Observability fundamentals
2. Prometheus + métricas Kubernetes
3. OpenTelemetry (SDK + Collector)
4. Tracing distribuído
5. SLOs e alertas baseados em métricas
6. Correlação logs ↔ traces ↔ métricas

---

## 1️⃣0️⃣ Conclusão (visão SRE)

OpenTelemetry é o padrão, Prometheus é o coletor de métricas, Grafana é o olho humano.

Se você domina:
- OTel + Kubernetes + métricas
você está muito bem posicionado como SRE / Platform Engineer.

Se quiser, no próximo passo eu posso:
- 📦 Te entregar um repo exemplo
- 📊 Criar dashboards prontos
- 🎯 Montar SLIs/SLOs reais
- 🚨 Criar alertas bem feitos (sem ruído)
