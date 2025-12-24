# Amazon RDS (PostgreSQL) – Métricas, SLIs e SLOs

## 📌 Objetivo
Definir métricas essenciais de observabilidade para **Amazon RDS PostgreSQL**, com exemplos práticos de **SLIs** e **SLOs**, voltados para ambientes de produção.

---

## 🧭 Contexto

PostgreSQL no RDS é um banco **stateful**, crítico e sensível a:
- Latência
- Conexões
- I/O
- Lock contention

Falhas aqui impactam diretamente a aplicação.

---

## ⭐ Golden Signals aplicados ao RDS PostgreSQL

| Signal | Aplicação |
|------|-----------|
| Latency | Query latency, commit latency |
| Traffic | Queries / TPS |
| Errors | Falhas de conexão, erros SQL |
| Saturation | CPU, IOPS, conexões |

---

## 📊 Métricas Importantes – Amazon RDS (PostgreSQL)

### 🔹 Tráfego

| Métrica | Descrição |
|------|----------|
| DatabaseConnections | Conexões ativas |
| TransactionsPerSecond | Transações por segundo |
| SelectThroughput | Selects/seg |
| InsertThroughput | Inserts/seg |
| UpdateThroughput | Updates/seg |
| DeleteThroughput | Deletes/seg |

---

### 🔹 Latência

| Métrica | Descrição |
|------|----------|
| ReadLatency | Latência de leitura |
| WriteLatency | Latência de escrita |
| CommitLatency | Tempo de commit |
| QueryLatency (Enhanced) | Latência média de queries |

📌 **Importante**: latência alta geralmente indica I/O ou lock.

---

### 🔹 Erros

| Métrica | Descrição |
|------|----------|
| ConnectionAttempts | Tentativas de conexão |
| FailedConnectionAttempts | Conexões falhadas |
| Deadlocks | Deadlocks detectados |
| ReplicationSlotDiskUsage | Uso excessivo de slots |

---

### 🔹 Saturação

| Métrica | Descrição |
|------|----------|
| CPUUtilization | Uso de CPU |
| FreeableMemory | Memória disponível |
| FreeStorageSpace | Espaço em disco |
| DiskQueueDepth | Fila de I/O |
| ReadIOPS / WriteIOPS | I/O por segundo |

---

### 🔹 Replicação (Read Replica)

| Métrica | Descrição |
|------|----------|
| ReplicaLag | Atraso da réplica |
| OldestReplicationSlotLag | Slot mais atrasado |

---

## 📈 Métricas Internas do PostgreSQL (Enhanced Monitoring / Performance Insights)

- Active sessions
- Top SQL by latency
- Locks por tipo
- Cache hit ratio
- Wait events (IO, CPU, Lock)

---

## 🎯 SLIs (Service Level Indicators)

### 🔹 Disponibilidade

SLI = (Tempo total - tempo indisponível) / tempo total

---

### 🔹 Latência de Query
SLI = % de queries com latency < 100ms

---

### 🔹 Commit
SLI = % de commits < 50ms

---

### 🔹 Conexões
SLI = % do tempo com conexões < 80% do max_connections

---

## 🏁 SLOs (Service Level Objectives)

### 🟢 RDS PostgreSQL – Produção Geral

- **Disponibilidade**: 99.95% mensal
- **Latência**: 95% das queries < 100ms
- **Commit**: 99% dos commits < 50ms

---

### 🟡 Aplicação de leitura pesada

- **Read Latency**: P95 < 50ms
- **Replica Lag**: < 5s
- **CPU**: < 75%

---

### 🔴 Banco crítico de negócio

- **Disponibilidade**: 99.99%
- **Deadlocks**: 0 tolerado
- **FreeStorageSpace**: > 20%

---

## 🚨 Alertas Recomendados

### Alta prioridade
- CPU > 85% por 5 min
- FreeStorageSpace < 15%
- ReplicaLag > 10s
- Deadlocks > 0
- FailedConnectionAttempts > 0

### Média prioridade
- DiskQueueDepth crescente
- FreeableMemory baixa
- DatabaseConnections > 80%

---

## 📉 Error Budget

Exemplo:
- SLO: 99.95%
- Error Budget: 0.05%

👉 Se estourar:
- Bloquear deploys
- Revisar queries
- Ajustar capacity

---

## 🛠️ Boas Práticas

- Use connection pooler (ex: PgBouncer)
- Monitore locks e wait events
- Habilite Performance Insights
- Use Read Replicas para escala de leitura
- Planeje storage autoscaling

---

## 📚 Referências Oficiais (AWS)

- Amazon RDS Metrics  
  https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/MonitoringOverview.html

- Amazon RDS for PostgreSQL  
  https://docs.aws.amazon.com/AmazonRDS/latest/PostgreSQLReleaseNotes/

- Performance Insights  
  https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_PerfInsights.html

- Enhanced Monitoring  
  https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_Monitoring.html

---

## 📚 Referências PostgreSQL / SRE

- PostgreSQL Monitoring  
  https://www.postgresql.org/docs/current/monitoring.html

- Google SRE – SLIs & SLOs  
  https://sre.google/workbook/implementing-slos/

- Use the Index, Luke  
  https://use-the-index-luke.com/

---

## ✅ Conclusão

RDS PostgreSQL confiável exige:
- Métricas corretas
- SLIs alinhados ao usuário
- SLOs realistas
- Alertas acionáveis
- Disciplina operacional
