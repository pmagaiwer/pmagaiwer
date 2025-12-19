# AWS RDS – Comandos Essenciais via AWS CLI

Este README reúne os principais comandos do **AWS CLI** para **listar, inspecionar e validar recursos do Amazon RDS**, com exemplos práticos para o dia a dia.

---

## 📌 Pré-requisitos

* AWS CLI instalado
* Credenciais configuradas:

```bash
aws configure
```

Ou usando profiles:

```bash
aws configure --profile meu-profile
```

---

## 📋 Listar instâncias RDS

Lista todas as instâncias RDS da conta/região:

```bash
aws rds describe-db-instances
```

Com saída simplificada (nome e engine):

```bash
aws rds describe-db-instances \
  --query "DBInstances[].{DB:DBInstanceIdentifier,Engine:Engine,Status:DBInstanceStatus}" \
  --output table
```

---

## 🔍 Listar uma instância RDS específica

```bash
aws rds describe-db-instances \
  --db-instance-identifier minha-instancia-rds
```

Buscar apenas endpoint e porta:

```bash
aws rds describe-db-instances \
  --db-instance-identifier minha-instancia-rds \
  --query "DBInstances[].Endpoint" \
  --output table
```

---

## 🧩 Listar clusters RDS (Aurora)

```bash
aws rds describe-db-clusters
```

Formato resumido:

```bash
aws rds describe-db-clusters \
  --query "DBClusters[].{Cluster:DBClusterIdentifier,Engine:Engine,Status:Status}" \
  --output table
```

---

## 👤 Listar snapshots RDS

Snapshots manuais e automáticos:

```bash
aws rds describe-db-snapshots
```

Somente snapshots manuais:

```bash
aws rds describe-db-snapshots \
  --snapshot-type manual
```

---

## 🔐 Listar grupos de parâmetros

```bash
aws rds describe-db-parameter-groups
```

---

## 🌐 Listar Subnet Groups

```bash
aws rds describe-db-subnet-groups
```

---

## 🛡️ Listar Security Groups associados ao RDS

```bash
aws rds describe-db-instances \
  --query "DBInstances[].{DB:DBInstanceIdentifier,SG:VpcSecurityGroups[].VpcSecurityGroupId}" \
  --output table
```

---

## 🔎 Validar conectividade (informativo)

Obter endpoint do banco:

```bash
aws rds describe-db-instances \
  --db-instance-identifier minha-instancia-rds \
  --query "DBInstances[].Endpoint.Address" \
  --output text
```

> ⚠️ Observação: O AWS CLI **não testa conexão TCP/SQL**. A validação real depende de:
>
> * Security Group liberando a porta
> * Subnet / VPC / VPN / Bastion
> * Cliente do banco (psql, mysql, etc.)

---

## 🧹 Deletar uma instância RDS (atenção!)

```bash
aws rds delete-db-instance \
  --db-instance-identifier minha-instancia-rds \
  --skip-final-snapshot
```

Ou criando snapshot final:

```bash
aws rds delete-db-instance \
  --db-instance-identifier minha-instancia-rds \
  --final-db-snapshot-identifier snapshot-final-minha-instancia
```

---

## 📎 Dicas úteis

* Sempre confira a **região**:

```bash
aws configure get region
```

* Forçar região:

```bash
aws rds describe-db-instances --region us-east-1
```

* Usar profiles:

```bash
aws rds describe-db-instances --profile prod
```

---

## 📚 Referência oficial

* Amazon RDS CLI: [https://docs.aws.amazon.com/cli/latest/reference/rds/](https://docs.aws.amazon.com/cli/latest/reference/rds/)

---

✅ README pronto para uso em times de **DevOps / Cloud / SRE**.
