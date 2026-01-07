# Arquitetura de Log Unification Multi-Account com OpenSearch e Delay Controlado

Arquitetura clássica para centralização de logs em ambientes multi-conta AWS, usando OpenSearch como motor de busca e delay proposital (~15 minutos) para otimizar custo, estabilidade e segurança.

---

## 🎯 Objetivo da arquitetura
- Centralizar logs de várias contas AWS
- Normalizar, enriquecer e controlar volume
- Disponibilizar consulta no OpenSearch
- Aceitar latência de ~15 minutos para:
  - Reduzir custo
  - Evitar picos
  - Garantir confiabilidade

---

## 🔁 Fluxo completo (fim a fim)

### 1️⃣ Produção dos logs (Contas A, B, C)
- EKS: logs de aplicações e containers
- EC2
- Outros serviços AWS
- **Coleta:** Fluent Bit (DaemonSet no EKS ou agente em EC2)
- **Status:** logs ainda crus (raw logs)

### 2️⃣ Agentes de coleta (Fluent Bit)
- Lê stdout/stderr de containers, arquivos de log, systemd/journald
- Enriquecimento: cluster, namespace, pod, account_id
- Envia logs via HTTP / Firehose / Kinesis
- **Agente leve, sem processamento pesado**

### 3️⃣ Buffer + desacoplamento (onde nasce o delay)
- Logs passam por Kinesis Data Streams ou Kinesis Firehose
- **Função:**
  - Absorver picos
  - Evitar sobrecarga no OpenSearch
  - Permitir flush controlado (ex: a cada 5, 10 ou 15 minutos)
- **Aqui começa a latência proposital**

### 4️⃣ Camada de processamento central
- EC2 / Auto Scaling Group rodando Fluentd, Logstash ou pipeline customizado
- **Funções:**
  - Parse (JSON, regex, grok)
  - Normalização
  - Enriquecimento (app, domínio, squad)
  - Drop de logs inúteis
  - Redirecionamento por tipo
- **Buffer em memória + disco**
- **Buffer + batch + flush = ~15 minutos**

### 5️⃣ Persistência intermediária (opcional)
- Logs podem ser salvos em S3 (raw ou parquet) antes do OpenSearch
- **Benefícios:** replay, compliance, disaster recovery

### 6️⃣ Indexação no OpenSearch
- Após batch completo, pipeline OK e backpressure resolvido
- Envio para Amazon OpenSearch Service
- Índices organizados por data, tipo de log, aplicação
- **Indexação em lote = melhor performance e custo**

### 7️⃣ Visualização e acesso
- Dashboards do OpenSearch
- Controle de acesso: Okta, IAM, RBAC
- Usuários: SRE, SecOps, Engenharia, Auditoria

---

## ⏱️ Por que exatamente 15 minutos de delay?
- **Motivos técnicos:**
  - Flush de batch (5–10 min)
  - Buffer de segurança
  - Retry em falha
  - Controle de throughput
- **Motivos financeiros:**
  - Menos shards ativos
  - Menos write IOPS
  - Menos custo no OpenSearch
- **Motivos operacionais:**
  - Evita perder logs em pico
  - Evita travar cluster
  - Logs chegam completos e consistentes

> Para observabilidade operacional, 15 min é aceitável
> Para segurança e auditoria, é até recomendado

---

## 🔍 Quando isso NÃO é ideal?
- Debug em tempo real
- Incident response imediato
- APM / tracing

**Nestes casos:**
- Logs críticos podem ir direto para OpenSearch
- Ou para CloudWatch Logs / Datadog
- Com pipeline paralelo (low latency)

---

## 🧠 Resumo mental simples
```
Aplicação
  ↓
Fluent Bit
  ↓
Kinesis / Firehose (buffer)
  ↓
Processamento central (batch)
  ↓
(Opcional) S3
  ↓
OpenSearch
  ↓
Dashboards (15 min depois)
```

---

## 🎯 Em uma frase

Essa arquitetura prioriza escala, custo e confiabilidade, aceitando latência controlada (~15 minutos) para garantir que os logs cheguem completos, organizados e sem derrubar o OpenSearch.
