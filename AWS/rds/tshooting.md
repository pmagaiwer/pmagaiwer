# Diagnóstico de Timeout – RDS PostgreSQL (Instância de Leitura)

## 📌 Resumo Executivo

Durante o período entre **12h e 15h**, foi identificada uma **rajada de consultas** na instância de leitura que resultou em **timeouts na aplicação**. O problema **não está relacionado a CPU, memória ou disco**, mas sim a **concorrência elevada e padrão de acesso**.

---

## 🔥 Principais Métricas que Contribuíram para Timeout

### 1️⃣ Queries per Second (QPS)

* Forte aumento entre 12h e 15h
* `queries_started` frequentemente maior que `queries_finished`
* Indica fila de execução e saturação do executor

**Impacto:** aumento de latência e timeout mesmo sem CPU a 100%

---

### 2️⃣ Connection Utilization (Connections)

* Crescimento progressivo de conexões
* Pouca liberação entre picos

**Impacto:**

* Disputa entre sessões
* Lentidão nas queries de leitura
* Timeouts de conexão e execução

---

### 3️⃣ Transactions per Second

* Acompanhou o crescimento do QPS
* Muitos commits pequenos

**Impacto:** overhead adicional no backend e menor throughput por query

---

### 4️⃣ IO Cache vs Disk Reads

* Cache hits altos (positivo)
* Picos de leitura em disco

**Impacto:**

* Cache não absorveu toda a carga
* Latência variável
* Possível falta de índice ou consultas não repetitivas

---

### 5️⃣ IO Latency

* Oscila junto com a rajada de consultas
* Não atinge valores críticos

**Conclusão:** efeito da concorrência, não causa raiz

---

## ❌ Métricas que NÃO foram causa do problema

* **Deadlocks:** praticamente inexistentes
* **Tuples DML:** baixos (ambiente de leitura)
* **Idle in Transaction:** irrelevante
* **Network Throughput:** dentro do normal
* **CPU / Memória:** sem sinais de exaustão

---

## 🧠 Diagnóstico Final

> **Rajada de consultas + alta concorrência**
> → aumento de conexões
> → fila de execução
> → latência variável
> → **timeout na aplicação**

Não se trata de limitação de hardware, mas de **padrão de uso e concorrência**.

---

## 🛠️ Ações Recomendadas (Ordem de Impacto)

### 1️⃣ Ajustar Pool de Conexões (Crítico)

* Limitar conexões por serviço
* Evitar 1 conexão por request
* Utilizar **PgBouncer (transaction mode)**

---

### 2️⃣ Identificar Queries Mais Pesadas

```sql
SELECT
  query,
  calls,
  total_time,
  mean_time
FROM pg_stat_statements
ORDER BY total_time DESC
LIMIT 10;
```

---

### 3️⃣ Implementar Cache de Leitura

* Redis ou cache em camada de aplicação
* TTL curto já reduz drasticamente carga

---

### 4️⃣ Criar Alertas no CloudWatch

* `DatabaseConnections`
* `Queries`
* `ReadLatency`

---

### 5️⃣ Escalabilidade de Leitura

* Adicionar **Read Replicas**
* Avaliar **Aurora Reader Endpoint**

---

## 📎 Conclusão

O timeout observado é consequência direta de **explosão de concorrência em leitura**, e não de falta de recursos físicos. Ajustes de pool, cache e análise de queries resolvem o problema de forma estrutural.
