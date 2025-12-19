# AWS Secrets Manager — Guia prático com AWS CLI

Este documento reúne os **principais conceitos e comandos** para **listar, criar, consultar e atualizar secrets no AWS Secrets Manager usando AWS CLI**.

---

## 📌 O que é o AWS Secrets Manager

O **AWS Secrets Manager** é um serviço da AWS usado para **armazenar, gerenciar e rotacionar informações sensíveis**, como:

* Senhas de banco de dados
* Tokens de API
* Credenciais de aplicações

As secrets são **criptografadas** (por padrão com KMS) e são **regionais**.

---

## ✅ Pré-requisitos

Antes de usar a AWS CLI com Secrets Manager, você precisa:

### 1️⃣ AWS CLI instalada

```bash
aws --version
```

### 2️⃣ Credenciais configuradas

```bash
aws configure
```

Ou usando profile:

```bash
aws configure --profile meu-profile
```

### 3️⃣ Permissões IAM mínimas

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "secretsmanager:ListSecrets",
        "secretsmanager:CreateSecret",
        "secretsmanager:PutSecretValue",
        "secretsmanager:DescribeSecret"
      ],
      "Resource": "*"
    }
  ]
}
```

---

## 📂 Listar secrets da conta

### 🔹 Listar todas as secrets

```bash
aws secretsmanager list-secrets
```

### 🔹 Listar secrets por região

```bash
aws secretsmanager list-secrets --region us-east-1
```

> ⚠️ Secrets são **regionais**. Se não aparecer nenhuma, verifique a região.

---

## 📄 Listar apenas os nomes (mais comum)

```bash
aws secretsmanager list-secrets \
  --query 'SecretList[].Name' \
  --output table
```

Ou:

```bash
aws secretsmanager list-secrets \
  --query 'SecretList[].Name' \
  --output text
```

---

## 🔍 Listar secrets com detalhes úteis

```bash
aws secretsmanager list-secrets \
  --query 'SecretList[].{Name:Name, ARN:ARN, LastChanged:LastChangedDate}' \
  --output table
```

---

## 🏷️ Filtrar secrets por tag

### Exemplo: secrets com tag `env=prod`

```bash
aws secretsmanager list-secrets \
  --filters Key=tag-key,Values=env \
  --query 'SecretList[].Name' \
  --output table
```

---

## ➕ Criar uma secret

### 🔹 Criar secret simples (string)

```bash
aws secretsmanager create-secret \
  --name airflow/db/password \
  --secret-string "minhaSenhaSuperSecreta"
```

### 🔹 Criar secret em formato JSON

```bash
aws secretsmanager create-secret \
  --name airflow/db/credentials \
  --secret-string '{
    "username": "airflow",
    "password": "<passowrd>",
    "host": "db.internal",
    "port": 5432
  }'
```

### 🔹 Criar secret usando arquivo

```bash
aws secretsmanager create-secret \
  --name airflow/api/keys \
  --secret-string file://secret.json
```

---

## 🔐 Criar secret usando KMS customizado

```bash
aws secretsmanager create-secret \
  --name airflow/secure/token \
  --kms-key-id arn:aws:kms:us-east-1:123456789012:key/xxxx \
  --secret-string "token-super-seguro"
```

---

## 🔄 Atualizar valor de uma secret

```bash
aws secretsmanager put-secret-value \
  --secret-id airflow/db/credentials \
  --secret-string "novoValor"
```

ou

```bash
 aws secretsmanager put-secret-value --secret-id airflow/db/credentials --secret-string "$(cat ./secret.json)"
 ```

``` 
{
    "ARN": "arn:aws:secretsmanager:us-east-1:780331102869:secret:airflow/db/credentials-DtPln2",
    "Name": "airflow/db/credentials",
    "VersionId": "29d53af8-8d41-46ac-90bc-d653963d6529",
    "VersionStages": [
        "AWSCURRENT"
    ]
}  
```

> 📌 Esse comando cria uma **nova versão** da secret.

---

## 🔎 Descrever uma secret (sem mostrar o valor)

```bash
aws secretsmanager describe-secret \
  --secret-id airflow/db/credentials
```

---

## ❌ 
 Deletar uma secret

```bash
aws secretsmanager delete-secret --secret-id airflow/db/credentials

```

---

## 👤 Usar profile específico

```bash
aws secretsmanager list-secrets --profile meu-profile
```

---

## ❌ Erros comuns

* Região incorreta
* Falta de permissão IAM
* Nome de secret duplicado
* JSON inválido

---

## 🧠 Boas práticas

* Use nomes hierárquicos: `app/env/tipo`
* Nunca versionar secrets no Git
* Prefira **IAM Roles** (EKS / EC2)
* Use rotação automática quando possível
* Restrinja acesso por IAM

---

## 🎯 Resumo rápido

| Ação           | Comando                           |
| -------------- | --------------------------------- |
| Listar secrets | `aws secretsmanager list-secrets` |
| Criar secret   | `create-secret`                   |
| Atualizar      | `put-secret-value`                |
| Ver metadados  | `describe-secret`                 |

---

📎 **Este README pode ser usado como documentação interna ou guia de onboarding para times DevOps / SRE.**
