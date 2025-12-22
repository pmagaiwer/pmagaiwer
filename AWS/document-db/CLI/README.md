# Documentação – Amazon DocumentDB (DEV → UAT)

Este documento consolida todas as informações discutidas neste chat sobre **Amazon DocumentDB**, incluindo conceitos, coleta de informações via AWS CLI, estratégia de clone/restauração, alteração de senha e criação de infraestrutura em **Terraform** para ambientes **DEV** e **UAT**.

---

## 1. O que é o Amazon DocumentDB

O **Amazon DocumentDB** é um banco de dados **NoSQL gerenciado pela AWS**, compatível com a **API do MongoDB**, projetado para armazenar dados no formato **documento (JSON/BSON)**.

### Principais características

* Modelo de dados flexível (documentos JSON)
* Alta disponibilidade (Multi-AZ)
* Escala automática de leitura
* Backups automáticos
* Criptografia em repouso (KMS) e em trânsito (TLS)
* Baixa sobrecarga operacional

### Casos de uso comuns

* APIs e backends de aplicações
* Microserviços
* Perfis de usuários e catálogos
* Dados semi-estruturados e eventos

---

## 2. Estratégia correta para "clonar" um cluster DocumentDB

### ❌ Clone direto

* Não existe clone online nativo no DocumentDB

### ✅ Abordagem recomendada

**Snapshot do cluster DEV + Restore em um novo cluster UAT**

#### Impacto no DEV

* Snapshot é online
* Sem downtime
* Impacto mínimo de I/O

#### Benefícios

* Ambientes isolados
* Endpoint novo
* Possibilidade de mudar:

  * Tipo de instância
  * Security Groups
  * Subnets
  * Tags
  * Retention e parâmetros

---

## 3. Comandos AWS CLI – Coleta de informações do cluster DEV

### 3.1 Autenticação

```bash
gimme-aws-creds --profile conta-dev
export AWS_PROFILE=conta-dev
```

### 3.2 Descrever o cluster

```bash
aws docdb describe-db-clusters \
  --db-cluster-identifier brain-dev
```

### 3.3 Coletar ARN do cluster

```bash
aws docdb describe-db-clusters \
  --db-cluster-identifier brain-dev \
  --query "DBClusters[0].DBClusterArn" \
  --output text
```

### 3.4 Listar TAGs

```bash
aws docdb list-tags-for-resource \
  --resource-name <DB_CLUSTER_ARN>
```

### 3.5 Informações relevantes do cluster

```bash
aws docdb describe-db-clusters \
  --db-cluster-identifier brain-dev \
  --query "DBClusters[0].{\
    Engine:Engine,\
    EngineVersion:EngineVersion,\
    BackupRetention:BackupRetentionPeriod,\
    KmsKeyId:KmsKeyId,\
    VpcSecurityGroups:VpcSecurityGroups,\
    SubnetGroup:DBSubnetGroup,\
    ParameterGroup:DBClusterParameterGroup,\
    IAMAuthEnabled:IAMDatabaseAuthenticationEnabled,\
    Port:Port\
  }"
```

### 3.6 Listar instâncias do cluster

```bash
aws docdb describe-db-instances \
  --query "DBInstances[?DBClusterIdentifier=='brain-dev'].{\
    Identifier:DBInstanceIdentifier,\
    InstanceClass:DBInstanceClass,\
    AZ:AvailabilityZone,\
    ParameterGroup:DBParameterGroups[0].DBParameterGroupName\
  }"
```

### 3.7 Security Groups

```bash
aws docdb describe-db-clusters \
  --db-cluster-identifier brain-dev \
  --query "DBClusters[0].VpcSecurityGroups[].VpcSecurityGroupId"
```

```bash
aws ec2 describe-security-groups --group-ids sg-xxxxxx
```

### 3.8 Subnet Group

```bash
aws docdb describe-db-subnet-groups \
  --db-subnet-group-name <SUBNET_GROUP_NAME>
```

### 3.9 Roles IAM associadas

```bash
aws docdb describe-db-clusters \
  --db-cluster-identifier brain-dev \
  --query "DBClusters[0].AssociatedRoles"
```

---

## 4. Snapshot e Restore (DEV → UAT)

### 4.1 Criar snapshot do DEV

```bash
aws docdb create-db-cluster-snapshot \
  --db-cluster-identifier brain-dev \
  --db-cluster-snapshot-identifier brain-dev-snap-uat
```

### 4.2 Restaurar snapshot para UAT

```bash
aws docdb restore-db-cluster-from-snapshot \
  --db-cluster-identifier brain-uat \
  --snapshot-identifier brain-dev-snap-uat \
  --engine docdb
```

### 4.3 Criar instância no cluster UAT

```bash
aws docdb create-db-instance \
  --db-instance-identifier brain-uat-0 \
  --db-cluster-identifier brain-uat \
  --db-instance-class db.t4g.medium
```

---

## 5. Alteração da senha do master user

### 5.1 Alterar senha imediatamente

```bash
aws docdb modify-db-cluster \
  --db-cluster-identifier brain-uat \
  --master-user-password 'NOVA_SENHA_FORTE' \
  --apply-immediately
```

### 5.2 Alterar senha na janela de manutenção

```bash
aws docdb modify-db-cluster \
  --db-cluster-identifier brain-uat \
  --master-user-password 'NOVA_SENHA_FORTE'
```

### 5.3 Validar alteração

```bash
aws docdb describe-db-clusters \
  --db-cluster-identifier brain-uat \
  --query "DBClusters[0].PendingModifiedValues"
```

### Observações

* Username não pode ser alterado
* Snapshot mantém a senha antiga
* Recomendado usar AWS Secrets Manager

---

## 6. Criação do cluster UAT com Terraform

### 6.1 Estrutura sugerida

```
terraform/
├── main.tf
├── variables.tf
├── locals.tf
├── documentdb.tf
└── envs/
    ├── dev.tfvars
    └── uat.tfvars
```

### 6.2 Variáveis principais

```hcl
variable "project_name" {}
variable "environment" {}
variable "docdb_instance_class" {}
variable "docdb_instance_count" { default = 1 }
variable "subnet_group_name" {}
variable "security_group_ids" { type = list(string) }
variable "cluster_parameter_group" {}
variable "instance_parameter_group" {}
variable "kms_key_id" { default = null }
variable "tags" { type = map(string) }
```

### 6.3 Locals

```hcl
locals {
  cluster_name = "brain-${var.project_name}-${var.environment}"
}
```

### 6.4 Cluster DocumentDB

```hcl
resource "aws_docdb_cluster" "this" {
  cluster_identifier = local.cluster_name
  engine             = "docdb"

  master_username = var.master_username
  master_password = var.master_password

  db_subnet_group_name           = var.subnet_group_name
  vpc_security_group_ids         = var.security_group_ids
  db_cluster_parameter_group_name = var.cluster_parameter_group

  backup_retention_period = 7
  skip_final_snapshot     = true
  kms_key_id              = var.kms_key_id

  tags = var.tags
}
```

### 6.5 Instâncias

```hcl
resource "aws_docdb_cluster_instance" "this" {
  count                   = var.docdb_instance_count
  identifier              = "${local.cluster_name}-${count.index}"
  cluster_identifier      = aws_docdb_cluster.this.id
  instance_class          = var.docdb_instance_class
  db_parameter_group_name = var.instance_parameter_group

  tags = var.tags
}
```

### 6.6 Exemplo `uat.tfvars`

```hcl
project_name = "nome"
environment  = "uat"

docdb_instance_class = "db.t4g.medium"
docdb_instance_count = 1

subnet_group_name = "docdb-subnet-group"
security_group_ids = ["sg-xxxxxx"]

cluster_parameter_group  = "brain-docdb-cluster-pg"
instance_parameter_group = "brain-docdb-instance-pg"

tags = {
  Project     = "brain"
  Environment = "uat"
  Owner       = "platform"
}
```

---

## 7. Boas práticas finais

* Sempre trocar senha após restore
* Usar Secrets Manager para credenciais
* Mascarar dados sensíveis no UAT
* Manter naming padrão por ambiente
* Evitar gerenciar senha diretamente no Terraform state

---

**Documento gerado a partir do histórico completo do chat.**
