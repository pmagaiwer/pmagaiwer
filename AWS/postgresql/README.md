# Validação de Conexão PostgreSQL no Airflow (EKS)

Este documento reúne **comandos práticos** para:

* Validar o endpoint usado pelo Airflow
* Testar conectividade com PostgreSQL via shell
* Confirmar se a conexão foi feita no **database correto**
* Sair corretamente do `psql`

---

## 1. Identificar o `conn_id` no Airflow

### Listar todas as conexões

```bash
airflow connections list
```

### Filtrar conexões PostgreSQL

```bash
airflow connections list | grep postgres
```

### Ver detalhes de uma conexão específica

```bash
airflow connections get <conn_id>
```

### Testar a conexão via Airflow

```bash
airflow connections test <conn_id>
```

---

## 2. Validar o Secret PostgreSQL no EKS

### Listar secrets do namespace

```bash
kubectl get secrets -n <namespace>
```

### Inspecionar o secret (estrutura)

```bash
kubectl describe secret postgres-secret -n <namespace>
```

### Ver valor real do endpoint (base64 decode)

```bash
kubectl get secret postgres-secret -n <namespace> \
  -o jsonpath='{.data.POSTGRES_HOST}' | base64 --decode
```

---

## 3. Confirmar que o Secret está carregado no pod do Airflow

### Descrever o pod

```bash
kubectl describe pod <airflow-pod> -n <namespace>
```

### Entrar no pod

```bash
kubectl exec -it <airflow-pod> -n <namespace> -- /bin/bash
```

### Validar variáveis de ambiente

```bash
env | grep POSTGRES
printenv | grep AIRFLOW__DATABASE
```

---

## 4. Validar o endpoint que o Airflow realmente usa

### Conferir via CLI do Airflow

```bash
airflow config get-value database sql_alchemy_conn
```

### Conferir no arquivo de configuração

```bash
cat $AIRFLOW_HOME/airflow.cfg | grep sql_alchemy_conn
```

---

## 5. Testes de conectividade com PostgreSQL (Shell)

### Teste de DNS

```bash
nslookup <endpoint>
```

### Teste de porta

```bash
nc -zv <endpoint> 5432
```

### Conexão direta via psql

```bash
psql "host=<endpoint> port=5432 dbname=<database> user=<user> sslmode=require"
```

---

## 6. Comandos PostgreSQL para validar o database correto

### Database atual

```sql
SELECT current_database();
```

### Usuário conectado

```sql
SELECT current_user;
```

### Host e porta

```sql
SELECT inet_server_addr(), inet_server_port();
```

### Informações completas da conexão

```psql
\conninfo
```

### Listar databases disponíveis

```psql
\l
```

### Listar tabelas

```psql
\dt
```

### Verificar se é o metadata DB do Airflow

```sql
SELECT COUNT(*) FROM dag;
SELECT COUNT(*) FROM task_instance;
```

---

## 7. Verificar SSL da conexão

```sql
SHOW ssl;
```

Ou:

```sql
SELECT ssl FROM pg_stat_ssl WHERE pid = pg_backend_pid();
```

---

## 8. Como sair do PostgreSQL (`psql`)

### Comando padrão

```psql
\q
```

### Alternativa

* `Ctrl + D`

Se estiver preso em um comando multilinha:

```psql
\r
\q
```

---

## 9. Checklist final de validação

* [ ] Secret atualizado
* [ ] Pod reiniciado
* [ ] `sql_alchemy_conn` aponta para o endpoint correto
* [ ] DNS resolve
* [ ] Porta 5432 acessível
* [ ] `airflow connections test` OK
* [ ] `current_database()` confere

---

📌 **Uso recomendado**: este arquivo pode ser versionado como **runbook de troubleshooting** para Airflow + PostgreSQL em EKS.
