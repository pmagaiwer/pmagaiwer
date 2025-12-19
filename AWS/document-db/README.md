# 📘 Listagem de Clusters Amazon DocumentDB via AWS CLI

Este README descreve os principais comandos da **AWS CLI** para **listar, consultar e inspecionar clusters do Amazon DocumentDB**.

---

## 📌 Pré-requisitos

* AWS CLI instalada
* Credenciais configuradas (`aws configure` ou `AWS_PROFILE`)
* Permissões IAM adequadas (`docdb:DescribeDBClusters`, `docdb:DescribeDBInstances`)

---

## ✅ Listar todos os clusters DocumentDB

```bash
aws docdb describe-db-clusters
```

---

## ✅ Listar apenas os nomes dos clusters

```bash
aws docdb describe-db-clusters \
  --query "DBClusters[].DBClusterIdentifier" \
  --output table
```

---

## ✅ Detalhar um cluster específico

```bash
aws docdb describe-db-clusters \
  --db-cluster-identifier NOME_DO_CLUSTER
```

Exemplo:

```bash
aws docdb describe-db-clusters \
  --db-cluster-identifier docdb-prod-cluster
```

---

## ✅ Visualizar status, endpoint e porta dos clusters

```bash
aws docdb describe-db-clusters \
  --query "DBClusters[].{\
Cluster:DBClusterIdentifier,\
Status:Status,\
Endpoint:Endpoint,\
ReaderEndpoint:ReaderEndpoint,\
Port:Port}" \
  --output table
```

---

## ✅ Listar instâncias associadas aos clusters

```bash
aws docdb describe-db-instances \
  --query "DBInstances[].{\
Instance:DBInstanceIdentifier,\
Cluster:DBClusterIdentifier,\
Class:DBInstanceClass,\
Status:DBInstanceStatus}" \
  --output table
```

---

## ✅ Filtrar clusters por status (ex: available)

```bash
aws docdb describe-db-clusters \
  --query "DBClusters[?Status=='available'].DBClusterIdentifier" \
  --output table
```

---

## 🔐 Validar informações de rede (opcional)

### Security Groups associados aos clusters

```bash
aws docdb describe-db-clusters \
  --query "DBClusters[].VpcSecurityGroups[].VpcSecurityGroupId"
```

### Porta padrão do DocumentDB

* Porta padrão: **27017**

---

## ✅ Checklist rápido

```text
describe-db-clusters
identificar cluster
ver endpoint
ver porta 27017
ver instâncias associadas
```

---

## 📚 Observações

* DocumentDB é compatível com **MongoDB** (não é PostgreSQL)
* Clusters privados exigem acesso via **VPC, Bastion, EC2 ou EKS**
* Sempre valide **Security Groups e Subnets** antes de testar conexão

---

📄 Documento criado para referência rápida de administração do Amazon DocumentDB via AWS CLI
