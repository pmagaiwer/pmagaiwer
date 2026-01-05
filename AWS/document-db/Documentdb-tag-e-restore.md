# Amazon DocumentDB — Tags e Restore de Snapshot (AWS CLI)

## Alterar valor de tag em um cluster DocumentDB

Claro 👍
No Amazon **DocumentDB**, você **altera o valor de uma tag reaplicando a mesma chave com o novo valor** (não existe “update”, o `add-tags-to-resource` sobrescreve).

⚠️ **Observação importante**: vou manter **exatamente a chave como você escreveu** (`Enviromente`). Se for um erro de digitação e a tag correta for `Environment`, ajuste conforme necessário.

---

### Comando AWS CLI

```bash
aws docdb add-tags-to-resource \
  --resource-name arn:aws:rds:REGION:ACCOUNT_ID:cluster:<endpoint>-uat \
  --tags Key=Enviromente,Value=uat
```

---

### Exemplo realista (ajuste para o seu ambiente)

```bash
aws docdb add-tags-to-resource \
  --resource-name arn:aws:rds:us-east-1:123456789012:cluster:<endpoint>-uat \
  --tags Key=Enviromente,Value=uat
```

---

### Validar se a tag foi alterada

```bash
aws docdb list-tags-for-resource \
  --resource-name arn:aws:rds:REGION:ACCOUNT_ID:cluster:<endpoint>-uat
```

---

### Notas rápidas (SRE mode 😄)

* Não é necessário remover a tag antiga
* O valor `dev` será automaticamente substituído por `uat`
* Permissão necessária: `docdb:AddTagsToResource`

---

## Restore de snapshot do cluster DEV para UAT

Vou te passar **o fluxo correto de restore de um snapshot do cluster DEV para criar um cluster UAT no Amazon DocumentDB usando AWS CLI**, no padrão SRE 🛠️

> ⚠️ **Importante**
>
> * **Não existe restore “em cima” de um cluster existente**
> * O restore **cria um novo cluster**
> * Se já existir um `<endpoint>-uat`, você precisa **excluir** ou usar outro nome

---

### 🔎 1. Listar snapshots do cluster DEV

```bash
aws docdb describe-db-cluster-snapshots \
  --db-cluster-identifier <endpoint>-dev
```

Ou, se for um snapshot manual específico:

```bash
aws docdb describe-db-cluster-snapshots \
  --snapshot-type manual
```

Anote o valor de:

```
DBClusterSnapshotIdentifier
```

---

### ♻️ 2. Restaurar snapshot criando o cluster UAT

```bash
aws docdb restore-db-cluster-from-snapshot \
  --db-cluster-identifier <endpoint>-uat \
  --snapshot-identifier <endpoint>-dev-snapshot-2025-01-10 \
  --engine docdb \
  --vpc-security-group-ids sg-xxxxxxx \
  --db-subnet-group-name docdb-subnet-group \
  --availability-zones us-east-1a us-east-1b us-east-1c \
  --tags Key=Enviromente,Value=uat
```

📌 **Esse comando cria apenas o cluster**, ainda **sem instâncias**.

---

### 🧩 3. Criar instâncias no cluster UAT

O DocumentDB exige pelo menos **1 instance**:

```bash
aws docdb create-db-instance \
  --db-instance-identifier <endpoint>-uat-instance-1 \
  --db-cluster-identifier <endpoint>-uat \
  --db-instance-class db.r6g.large \
  --engine docdb
```

> Repita o comando se quiser adicionar mais réplicas.

---

### 🔐 4. (Opcional) Atualizar parâmetros de segurança

Exemplo de alteração de senha do usuário master:

```bash
aws docdb modify-db-cluster \
  --db-cluster-identifier <endpoint>-uat \
  --master-user-password 'NovaSenhaForte' \
  --apply-immediately
```

---

### 🔍 5. Validar status do cluster

```bash
aws docdb describe-db-clusters \
  --db-cluster-identifier <endpoint>-uat
```

Espere até o status:

```
Status: available
```

---

## 🧠 Boas práticas (experiência real de produção)

* ✔️ Valide **parameter groups** (DEV ≠ UAT)
* ✔️ Confirme **Security Groups**
* ✔️ Ajuste **backup retention**
* ✔️ Confirme **tags de custo**
* ✔️ Revise a **engine version** do snapshot

---

### Próximos passos (opcional)

* 🔁 Criar um **script bash completo e idempotente**
* 🧪 Simular **restore blue/green**
* 🔐 Usar **AWS_PROFILE / STS assume-role**
* 📦 Validar compatibilidade do snapshot antes do restore

---

> Documento voltado para times SRE / Plataforma usando Amazon DocumentDB via AWS CLI.
