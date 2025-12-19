# Validação de Consumo – Amazon DocumentDB (Cluster Específico)

Este guia mostra **como validar o consumo de um Amazon DocumentDB informando explicitamente o nome de um cluster**, utilizando **AWS CLI + CloudWatch Metrics**.

> ⚠️ Importante: Métricas de **CPU, memória e conexões são por instância**. Métricas de **storage são por cluster**.

---

## 📌 Pré-requisitos

* AWS CLI configurado
* Permissões para:

  * `docdb:Describe*`
  * `cloudwatch:GetMetricStatistics`

---

## 1️⃣ Definir o cluster alvo

Defina o nome do cluster como variável de ambiente:

```bash
export DOCDB_CLUSTER=my-docdb-cluster
```

---

## 2️⃣ Listar instâncias do cluster

```bash
aws docdb describe-db-instances \
  --query "DBInstances[?DBClusterIdentifier=='$DOCDB_CLUSTER'].{Instance:DBInstanceIdentifier,Class:DBInstanceClass,Status:DBInstanceStatus}" \
  --output table
```

📌 Use o valor de **DBInstanceIdentifier** nos próximos comandos.

---

## 3️⃣ Validar consumo de CPU (por instância)

```bash
export DOCDB_INSTANCE=my-docdb-instance

aws cloudwatch get-metric-statistics \
  --namespace AWS/DocDB \
  --metric-name CPUUtilization \
  --dimensions Name=DBInstanceIdentifier,Value=$DOCDB_INSTANCE \
  --statistics Average Maximum \
  --period 300 \
  --start-time $(date -u -d '1 hour ago' +%Y-%m-%dT%H:%M:%SZ) \
  --end-time $(date -u +%Y-%m-%dT%H:%M:%SZ)
```

🚨 Atenção se CPU > **70–80%** por períodos prolongados.

---

## 4️⃣ Validar memória disponível

```bash
aws cloudwatch get-metric-statistics \
  --namespace AWS/DocDB \
  --metric-name FreeableMemory \
  --dimensions Name=DBInstanceIdentifier,Value=$DOCDB_INSTANCE \
  --statistics Average Minimum \
  --period 300 \
  --start-time $(date -u -d '1 hour ago' +%Y-%m-%dT%H:%M:%SZ) \
  --end-time $(date -u +%Y-%m-%dT%H:%M:%SZ)
```

📉 Valores muito baixos indicam pressão de memória.

---

## 5️⃣ Validar conexões abertas

```bash
aws cloudwatch get-metric
```
