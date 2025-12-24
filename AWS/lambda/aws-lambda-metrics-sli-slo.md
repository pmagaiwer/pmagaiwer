# AWS Lambda – Métricas, SLIs e SLOs

## 📌 Objetivo
Definir métricas essenciais de observabilidade para **AWS Lambda**, com exemplos práticos de **SLIs** e **SLOs**, aplicáveis a ambientes de produção.

---

## 🧭 Contexto

AWS Lambda é um serviço **event-driven** e **serverless**, portanto:
- Latência
- Erros
- Concorrência
- Backpressure

são fatores críticos para confiabilidade.

---

## ⭐ Golden Signals aplicados à Lambda

| Signal | Como se aplica à Lambda |
|------|------------------------|
| Latency | Duration |
| Traffic | Invocations |
| Errors | Errors, DLQ |
| Saturation | Throttles, Concurrency |

---

## 📊 Métricas Importantes – AWS Lambda

### 🔹 Tráfego

| Métrica | Descrição |
|------|----------|
| Invocations | Total de execuções |
| ConcurrentExecutions | Execuções simultâneas |
| ProvisionedConcurrencyUtilization | Uso da PC |

---

### 🔹 Latência

| Métrica | Descrição |
|------|----------|
| Duration | Tempo de execução |
| Duration P90 / P95 / P99 | Cauda de latência |
| InitDuration | Tempo de cold start |

📌 **Atenção**: `InitDuration` impacta diretamente APIs síncronas.

---

### 🔹 Erros

| Métrica | Descrição |
|------|----------|
| Errors | Execuções com falha |
| DestinationDeliveryFailures | Falha ao enviar para destino |
| DeadLetterErrors | Erros enviados à DLQ |

---

### 🔹 Saturação

| Métrica | Descrição |
|------|----------|
| Throttles | Execuções bloqueadas |
| UnreservedConcurrentExecutions | Uso de concorrência global |
| ReservedConcurrentExecutions | Limite configurado |

---

### 🔹 Streams / Filas (quando aplicável)

| Métrica | Descrição |
|------|----------|
| IteratorAge | Atraso de processamento |
| MaximumEventAge | Eventos expirados |
| OnFailureDestinationInvocations | Reenvios |

---

## 📈 Métricas de Negócio (Exemplos)

- Pedidos processados por minuto
- Eventos válidos vs inválidos
- Tempo médio de processamento por evento
- Taxa de retries

📌 Essas métricas **não vêm prontas** — devem ser customizadas.

---

## 🎯 SLIs (Service Level Indicators)

### 🔹 Disponibilidade

SLI = (Invocations - Errors) / Invocations

---

### 🔹 Latência
SLI = % de execuções com Duration < 500ms

---

### 🔹 Processamento Assíncrono (SQS / Streams)
SLI = % de mensagens processadas em até 5 minutos

---

### 🔹 Cold Start (APIs críticas)
SLI = % de execuções com InitDuration < 1s

---

## 🏁 SLOs (Service Level Objectives)

### 🟢 Lambda síncrona (API Gateway)

- **Disponibilidade**: 99.9% mensal
- **Latência**: 95% das execuções < 500ms
- **Erros**: < 0.5%

---

### 🟡 Lambda assíncrona (SQS / SNS)

- **Processamento**: 99% das mensagens em até 5 minutos
- **Erro**: < 1%
- **DLQ**: < 0.1% das mensagens

---

### 🔵 Lambda crítica de negócio

- **Disponibilidade**: 99.99%
- **Throttles**: 0 tolerado
- **Retries**: < 0.3%

---

## 🚨 Alertas Recomendados

### Alta prioridade
- Errors > 1% por 5 min
- Throttles > 0
- DLQ > 0 mensagens
- IteratorAge crescente

### Média prioridade
- Duration P95 > 80% do timeout
- Concurrency próxima do limite

---

## 📉 Error Budget

Exemplo:
- SLO: 99.9%
- Error Budget: 0.1%

👉 Se o budget for consumido:
- Congelar deploy
- Focar em estabilidade
- Reduzir mudanças

---

## 🛠️ Boas Práticas

- Use DLQ ou destinos assíncronos
- Configure Reserved Concurrency para serviços críticos
- Use Provisioned Concurrency para APIs sensíveis a cold start
- Monitore cauda (P95 / P99)
- Alinhe métricas técnicas com impacto de negócio

---

## 📚 Referências Oficiais (AWS)

- AWS Lambda Metrics (CloudWatch)  
  https://docs.aws.amazon.com/lambda/latest/dg/monitoring-metrics.html

- AWS Lambda Observability  
  https://docs.aws.amazon.com/lambda/latest/dg/lambda-observability.html

- AWS Lambda Error Handling  
  https://docs.aws.amazon.com/lambda/latest/dg/invocation-async.html

- AWS Well-Architected – Serverless Lens  
  https://docs.aws.amazon.com/wellarchitected/latest/serverless-lens/welcome.html

---

## 📚 Referências SRE / Terceiros

- Google SRE – SLIs & SLOs  
  https://sre.google/workbook/implementing-slos/

- Observability for Serverless  
  https://www.cncf.io/blog/2021/05/12/observability-for-serverless/

- AWS Architecture Blog – Lambda Best Practices  
  https://aws.amazon.com/blogs/architecture/tag/aws-lambda/

---

## ✅ Conclusão

Lambda confiável exige:
- Métricas corretas
- SLIs bem definidos
- SLOs realistas
- Alertas acionáveis
- Foco em impacto ao usuário

📊 Dashboard 1 — AWS Lambda – Visão Geral (Golden Signals)
```json
{
  "widgets": [
    {
      "type": "metric",
      "x": 0,
      "y": 0,
      "width": 12,
      "height": 6,
      "properties": {
        "title": "Invocations & Errors",
        "metrics": [
          [ "AWS/Lambda", "Invocations", "FunctionName", "MINHA_LAMBDA" ],
          [ ".", "Errors", ".", "." ]
        ],
        "region": "us-east-1",
        "stat": "Sum",
        "period": 300
      }
    },
    {
      "type": "metric",
      "x": 12,
      "y": 0,
      "width": 12,
      "height": 6,
      "properties": {
        "title": "Duration (P95)",
        "metrics": [
          [ "AWS/Lambda", "Duration", "FunctionName", "MINHA_LAMBDA", { "stat": "p95" } ]
        ],
        "region": "us-east-1",
        "period": 300
      }
    },
    {
      "type": "metric",
      "x": 0,
      "y": 6,
      "width": 12,
      "height": 6,
      "properties": {
        "title": "Throttles",
        "metrics": [
          [ "AWS/Lambda", "Throttles", "FunctionName", "MINHA_LAMBDA" ]
        ],
        "region": "us-east-1",
        "stat": "Sum",
        "period": 300
      }
    },
    {
      "type": "metric",
      "x": 12,
      "y": 6,
      "width": 12,
      "height": 6,
      "properties": {
        "title": "Concurrent Executions",
        "metrics": [
          [ "AWS/Lambda", "ConcurrentExecutions", "FunctionName", "MINHA_LAMBDA" ]
        ],
        "region": "us-east-1",
        "stat": "Maximum",
        "period": 300
      }
    }
  ]
}
```

📊 Dashboard 2 — AWS Lambda – Latência & Cold Start

```json
{
  "widgets": [
    {
      "type": "metric",
      "x": 0,
      "y": 0,
      "width": 24,
      "height": 6,
      "properties": {
        "title": "Duration P50 / P95 / P99",
        "metrics": [
          [ "AWS/Lambda", "Duration", "FunctionName", "MINHA_LAMBDA", { "stat": "p50" } ],
          [ ".", "Duration", ".", ".", { "stat": "p95" } ],
          [ ".", "Duration", ".", ".", { "stat": "p99" } ]
        ],
        "region": "us-east-1",
        "period": 300
      }
    },
    {
      "type": "metric",
      "x": 0,
      "y": 6,
      "width": 24,
      "height": 6,
      "properties": {
        "title": "Cold Start (InitDuration)",
        "metrics": [
          [ "AWS/Lambda", "InitDuration", "FunctionName", "MINHA_LAMBDA", { "stat": "p95" } ]
        ],
        "region": "us-east-1",
        "period": 300
      }
    }
  ]
}
```

📊 Dashboard 3 — AWS Lambda + SQS (Backlog & Saúde)
```json
{
  "widgets": [
    {
      "type": "metric",
      "x": 0,
      "y": 0,
      "width": 12,
      "height": 6,
      "properties": {
        "title": "SQS - Messages Visible",
        "metrics": [
          [ "AWS/SQS", "ApproximateNumberOfMessagesVisible", "QueueName", "MINHA_FILA" ]
        ],
        "region": "us-east-1",
        "stat": "Average",
        "period": 300
      }
    },
    {
      "type": "metric",
      "x": 12,
      "y": 0,
      "width": 12,
      "height": 6,
      "properties": {
        "title": "SQS - Age of Oldest Message",
        "metrics": [
          [ "AWS/SQS", "ApproximateAgeOfOldestMessage", "QueueName", "MINHA_FILA" ]
        ],
        "region": "us-east-1",
        "stat": "Maximum",
        "period": 300
      }
    },
    {
      "type": "metric",
      "x": 0,
      "y": 6,
      "width": 12,
      "height": 6,
      "properties": {
        "title": "Lambda Errors",
        "metrics": [
          [ "AWS/Lambda", "Errors", "FunctionName", "MINHA_LAMBDA" ]
        ],
        "region": "us-east-1",
        "stat": "Sum",
        "period": 300
      }
    },
    {
      "type": "metric",
      "x": 12,
      "y": 6,
      "width": 12,
      "height": 6,
      "properties": {
        "title": "Lambda Duration (P95)",
        "metrics": [
          [ "AWS/Lambda", "Duration", "FunctionName", "MINHA_LAMBDA", { "stat": "p95" } ]
        ],
        "region": "us-east-1",
        "period": 300
      }
    }
  ]
}
```


## AWS CLI
```bash
aws cloudwatch put-dashboard \
  --dashboard-name Lambda-Overview \
  --dashboard-body file://cloudwatch-lambda-overview-dashboard.json
```
