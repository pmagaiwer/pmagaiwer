# Gerenciamento de Usuários IAM via AWS CLI

Este documento descreve como **listar usuários IAM**, **consultar um usuário específico** e **deletar um usuário IAM corretamente** utilizando a **AWS CLI**.

---

## 📌 Pré-requisitos

* AWS CLI instalada
* Credenciais configuradas (`aws configure`)
* Permissões IAM adequadas (ex: `iam:ListUsers`, `iam:GetUser`, `iam:DeleteUser`)

---

## ✅ Listar todos os usuários IAM

```bash
aws iam list-users
```

Formato mais legível:

```bash
aws iam list-users --query "Users[].UserName" --output table
```

---

## ✅ Listar um usuário IAM específico

```bash
aws iam get-user --user-name NOME_DO_USUARIO
```

Exemplo:

```bash
aws iam get-user --user-name pierre.santos
```

---

## ⚠️ Antes de deletar um usuário IAM

A AWS **não permite deletar um usuário** se ele possuir recursos associados.

Siga **todos os passos abaixo** antes de executar o delete.

---

### 1️⃣ Listar e remover Access Keys

Listar:

```bash
aws iam list-access-keys --user-name NOME_DO_USUARIO
```

Remover:

```bash
aws iam delete-access-key \
  --user-name NOME_DO_USUARIO \
  --access-key-id ACCESS_KEY_ID
```

---

### 2️⃣ Remover políticas anexadas diretamente

Listar:

```bash
aws iam list-attached-user-policies --user-name NOME_DO_USUARIO
```

Remover:

```bash
aws iam detach-user-policy \
  --user-name NOME_DO_USUARIO \
  --policy-arn POLICY_ARN
```

---

### 3️⃣ Remover políticas inline

Listar:

```bash
aws iam list-user-policies --user-name NOME_DO_USUARIO
```

Remover:

```bash
aws iam delete-user-policy \
  --user-name NOME_DO_USUARIO \
  --policy-name POLICY_NAME
```

---

### 4️⃣ Remover o usuário de grupos

Listar grupos:

```bash
aws iam list-groups-for-user --user-name NOME_DO_USUARIO
```

Remover do grupo:

```bash
aws iam remove-user-from-group \
  --user-name NOME_DO_USUARIO \
  --group-name NOME_DO_GRUPO
```

---

### 5️⃣ Remover login no Console AWS

```bash
aws iam delete-login-profile --user-name NOME_DO_USUARIO
```

---

### 6️⃣ (Opcional) Remover MFA

Listar dispositivos MFA:

```bash
aws iam list-mfa-devices --user-name NOME_DO_USUARIO
```

Desativar:

```bash
aws iam deactivate-mfa-device \
  --user-name NOME_DO_USUARIO \
  --serial-number SERIAL_MFA
```

---

## ❌ Deletar o usuário IAM

Após remover **todas as dependências**:

```bash
aws iam delete-user --user-name NOME_DO_USUARIO
```

---

## ✅ Checklist rápido

```text
list-users
get-user
list-access-keys
delete-access-key
list-attached-user-policies
detach-user-policy
list-user-policies
delete-user-policy
list-groups-for-user
remove-user-from-group
delete-login-profile
deactivate-mfa-device
delete-user
```

---

## 🔐 Boas práticas

* Sempre prefira **IAM Roles** ao invés de usuários com Access Key
* Utilize **Least Privilege**
* Audite usuários inativos regularmente

---

📄 Documento gerado para referência rápida de administração IAM via AWS CLI
