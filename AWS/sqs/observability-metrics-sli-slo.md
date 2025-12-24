# Observabilidade – Métricas, SLI e SLO

## 📌 Objetivo
Definir métricas essenciais para observabilidade e exemplos práticos de **SLIs** e **SLOs**, aplicáveis a arquiteturas modernas (AWS, serverless e distribuídas).

---

## 🧭 Conceitos Fundamentais

### Observabilidade
Capacidade de entender o estado interno de um sistema a partir de seus **outputs**:
- Métricas
- Logs
- Traces

---

### Golden Signals (Google SRE)
Quatro sinais essenciais:
1. **Latency**
2. **Traffic**
3. **Errors**
4. **Saturation**

---

## 📊 Métricas Essenciais (Visão Geral)

### 🔹 Latência
- Tempo de resposta
- P50 / P90 / P95 / P99

### 🔹 Tráfego
- Requests por segundo
- Mensagens por segundo
- Throughput

### 🔹 Erros
- Error rate (%)
- 4xx / 5xx
- Timeouts
- Retries

### 🔹 Saturação
- CPU
- Memória
- Concurrency
- Backlog de filas

---

## ☁️ Métricas Importantes por Serviço (AWS)

---

### 🧩 AWS Lambda

| Métrica | Descrição |
|------|--------|
| Invocations | Total de execuções |
| Duration | Tempo de execução |
| Errors | Execuções com erro |
| Throttles | Execuções bloqueadas |
| ConcurrentExecutions | Execuções simultâneas |
| IteratorAge | Atraso em streams |
| DeadLetterErrors | Erros enviados à DLQ |

📌 **Alertas comuns**
- Erros > 1%
- Throttles > 0
- Duration próximo ao timeout

---

### 📬 Amazon SQS

| Métrica | Descrição |
|------|--------|
| ApproximateNumberOfMessagesVisible | Mensagens prontas |
| ApproximateAgeOfOldestMessage | Idade da mensagem |
| NumberOfMessagesReceived | Consumo |
| NumberOfMessagesSent | Produção |
| NumberOfMessagesNotVisible | Em processamento |

📌 **Alertas comuns**
- Backlog crescente
- Mensagens antigas
- Consumo menor que produção

---

### 📢 Amazon SNS

| Métrica | Descrição |
|------|--------|
| NumberOfMessagesPublished | Publicações |
| NumberOfNotificationsDelivered | Entregas |
| NumberOfNotificationsFailed | Falhas |
| PublishSize | Tamanho da mensagem |

---

### 🌐 API Gateway / ALB

| Métrica | Descrição |
|------|--------|
| Latency | Tempo total |
| IntegrationLatency | Backend |
| 4XXError / 5XXError | Erros |
| RequestCount | Tráfego |

---

### 💾 Banco de Dados (ex: RDS / DynamoDB)

| Métrica | Descrição |
|------|--------|
| CPUUtilization | Uso de CPU |
| Read/WriteLatency | Latência |
| ThrottledRequests | Limites |
| Errors | Falhas |

---

## 📜 Logs – O que garantir

Logs devem responder:
- O que aconteceu?
- Quando?
- Com qual impacto?
- Para qual request / trace?

### Boas práticas
- Log estruturado (JSON)
- Correlation ID
- Nível correto (INFO, WARN, ERROR)
- Sem dados sensíveis

---

## 🧵 Traces – O que observar

- Tempo total de uma requisição
- Onde ocorreu o gargalo
- Comunicação entre serviços

Ferramentas:
- AWS X-Ray
- OpenTelemetry
- Jaeger / Tempo

---

## 🎯 SLIs (Service Level Indicators)

### Exemplos de SLIs

#### 🔹 Disponibilidade

SLI = (Total de requests - requests com erro) / Total de requests

#### 🔹 Latência

SLI = % de requests com latency < 300ms


#### 🔹 Processamento assíncrono (SQS)
SLI = % de mensagens processadas em menos de 2 minutos


---

## 🏁 SLOs (Service Level Objectives)

### Exemplos Realistas

#### 🔹 API síncrona
- **Disponibilidade**: 99.9% mensal
- **Latência**: 95% das requests < 300ms

---

#### 🔹 Lambda consumindo SQS
- **Processamento**: 99% das mensagens processadas em até 5 minutos
- **Erro**: < 0.5% de falhas

---

#### 🔹 Pipeline de eventos (SNS + SQS)
- **Entrega**: 99.99% das mensagens entregues ao SQS
- **Backlog**: mensagens com idade < 10 minutos

---

## 🚨 Alertas vs SLO

### ❌ Não alertar em tudo
- Métrica ≠ Alerta

### ✅ Alertar em:
- Violação de SLO
- Tendência de violação
- Saturação crítica

---

## 📉 Error Budget

### Conceito

Error Budget = 1 - SLO


Exemplo:
- SLO: 99.9%
- Error Budget: 0.1%

👉 Consumiu o budget?
- Congelar deploy
- Priorizar estabilidade

---

## 🧠 Boas Práticas de Observabilidade

- Métricas orientadas ao usuário
- Dashboards simples
- Alertas acionáveis
- SLO antes de SLA
- Observabilidade como produto

---

## 📚 Referências

### AWS
- CloudWatch Metrics  
  https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/working_with_metrics.html

- AWS Observability Best Practices  
  https://aws.amazon.com/observability/

- AWS Well-Architected – Operational Excellence  
  https://docs.aws.amazon.com/wellarchitected/latest/operational-excellence-pillar/welcome.html

---

### SRE / Terceiros
- Google SRE Book  
  https://sre.google/sre-book/

- SLIs & SLOs Explained  
  https://sre.google/workbook/implementing-slos/

- OpenTelemetry  
  https://opentelemetry.io/docs/

---

## ✅ Conclusão

Observabilidade eficaz:
- Começa com **métricas certas**
- É guiada por **SLIs**
- É protegida por **SLOs**
- Evita alert fatigue
- Escala com o sistema
