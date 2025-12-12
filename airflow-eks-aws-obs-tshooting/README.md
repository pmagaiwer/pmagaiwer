# 🌀 Arquitetura Completa – Airflow, EKS, APIs, Lambda, Observabilidade e Fluxos AWS

Este documento consolida toda a arquitetura, funcionamento, fluxos, comandos e procedimentos de troubleshooting para operação de Airflow, APIs em EKS, Lambda Functions, mensageria via SNS/SQS, integração com buckets S3, observabilidade com CloudWatch, OpenSearch e Datadog, além de instruções práticas para debugging.

---

# 📌 1. Visão Geral da Arquitetura

A solução utiliza:

- **EKS (Kubernetes AWS)** – Hospeda:
  - APIs (AgroWatch e CloudRanger)
  - Airflow (scheduler, webserver, workers)
  - CronJobs (sincronização de buckets e atualização de DAGs)
- **Airflow** – Pipeline ETL, ingestão e atualização periódica
- **AWS Lambda** – Execuções paralelas e integrações auxiliares (será descontinuada em parte)
- **S3 Buckets** – Gatilho para atualização de DAGs, ingestão e datasets
- **SNS/SQS** – Mensageria e notificações
- **Secret Manager** – Armazenamento seguro de credenciais
- **Bitbucket + Jenkins** – CI/CD e publicação de imagens
- **Redis + Dockerfile customizado** – Desenvolvimento local
- **Observabilidade com Datadog, CloudWatch e OpenSearch**

Inicialmente o produto consumia dados diretamente através de uma Lambda que acessava SQL.  
Agora, foram criadas **duas APIs no EKS** para consumir os dados de forma mais segura e escalável.

---

# 📌 2. Airflow – Pipelines, DAGs e Fluxos ETL

Funções principais:

- Extração de dados públicos (IBGE, FUNAI, INCRA, etc.)
- Atualização periódica de camadas **bronze**
- Monitoramento de sucesso/falha com SNS/SQS
- Sincronização automática de DAGs quando há novos arquivos no S3
- Execução distribuída no Kubernetes (via K8sPodOperator ou CeleryK8sExecutor)

### 🔍 Logs do Airflow no EKS

```bash
kubectl logs deploy/airflow-webserver -n airflow -f
kubectl logs deploy/airflow-scheduler -n airflow -f
kubectl logs POD_NAME -n airflow -f
```

### Reiniciar serviços do Airflow

```bash
kubectl rollout restart deployment airflow-scheduler -n airflow
kubectl rollout restart deployment airflow-webserver -n airflow
```

---

# 📌 3. APIs – AgroWatch e CloudRanger (Rodando no EKS)

Hospedadas no EKS para fornecer:

- Dados geoespaciais (ex.: terras indígenas via FUNAI)
- Dados de propriedades e análises agrícolas
- Autenticação via IAM Token
- Foco em consultas rápidas e integradas ao ambiente

O Bitbucket aciona o Jenkins, que gera a imagem e atualiza o EKS.

### Logs das APIs

```bash
kubectl logs POD_NAME -n apis -f
```

### Reiniciar API manualmente

```bash
kubectl rollout restart deployment nome-da-api -n apis
```

---

# 📌 4. CronJob no EKS – Verificação de Arquivos no Bucket

Este CronJob:

- Verifica S3 para detectar arquivos novos
- Caso haja atualização:
  - Atualiza o SVC ou Deployment
  - Notifica Airflow para recarregar DAGs
- Caso falhe:
  - É necessário executar comandos manualmente via kubectl

### Logs do CronJob

```bash
kubectl get cronjobs -n airflow
kubectl logs JOB_NAME -n airflow
```

### Executar script manualmente dentro do pod

```bash
kubectl exec -it POD -- python /app/scripts/sync_buckets.py
```

---

# 📌 5. AWS Lambda – Execuções e Legado

Ainda utilizada para:

- Funções rápidas
- Processos auxiliares
- Eventos assíncronos

As Lambdas utilizam:

- Secrets do Secret Manager
- IAM Roles
- Integração com SNS/SQS

### Logs no CloudWatch

CloudWatch Console → Lambda → Logs  
ou via CLI:

```bash
aws logs tail /aws/lambda/NOME_DA_LAMBDA --follow
```

---

# 📌 6. Mensageria – SNS e SQS

Usos principais:

- Notificação de DAGs do Airflow
- Comunicação entre APIs e Airflow
- Fluxos assíncronos entre serviços

SNS → publica  
SQS → consome e gera ACK

---

# 📌 7. Segurança – AWS Secret Manager

Todos os acessos sensíveis ficam armazenados no Secret Manager:

```bash
aws secretsmanager get-secret-value --secret-id meu-secret
```

Nos pods, podem ser lidos via:

- Variáveis de ambiente
- Mounted secrets
- IRSA (IAM Roles for Service Accounts)

---

# 📌 8. Observabilidade

### 🔍 CloudWatch

- Logs de Lambda
- Logs do EKS (Container Insights)
- Logs de CronJobs
- Métricas automáticas

### 📊 Datadog

- Logs das APIs
- Dashboards de métricas
- APM para tracing distribuído

### 🔎 OpenSearch Dashboards

- Armazena logs estruturados
- Permite buscas avançadas

---

# 📌 9. Troubleshooting – Checklists Práticos

### 🟩 Airflow não atualiza DAGs

- Verificar bucket
- Verificar CronJob
- Verificar scheduler

Reiniciar serviços:

```bash
kubectl rollout restart deployment airflow-scheduler -n airflow
```

### 🟩 API não atualizou após merge no Bitbucket

- Jenkins rodou?
- Tag foi publicada?
- EKS atualizou Deployment?

Forçar atualização:

```bash
kubectl rollout restart deployment minhas-api -n apis
```

### 🟩 CronJob não processou arquivos do Bucket

Logs:

```bash
kubectl logs JOB_NAME -n airflow
```

Executar script manual:

```bash
kubectl exec -it POD -- python /app/scripts/sync_buckets.py
```

---

# 📌 10. Comandos Essenciais para EKS

### Listar pods

```bash
kubectl get pods -n airflow
kubectl get pods -n apis
```

### Ver logs

```bash
kubectl logs POD_NAME -n NAMESPACE -f
```

### Restart de deployment

```bash
kubectl rollout restart deployment NOME -n NAMESPACE
```

### Aplicar mudanças

```bash
kubectl apply -f arquivo.yaml
```

### Acessar pod em shell

```bash
kubectl exec -it POD -n NAMESPACE -- bash
```

---

# 📌 11. Links Recomendados para Estudo

### Airflow
https://airflow.apache.org/docs/apache-airflow/stable/start/index.html

### Kubernetes / EKS
https://www.eksworkshop.com/  
https://www.youtube.com/watch?v=Y_tXu6n24xI

### AWS Lambda
https://www.youtube.com/watch?v=eOBq__h4OJ4

### SNS/SQS
https://docs.aws.amazon.com/sns/latest/dg/welcome.html  
https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/welcome.html

### Datadog
https://docs.datadoghq.com/logs/

### Jenkins CI/CD
https://www.youtube.com/watch?v=oWgadxVJoh8

---

# 📌 12. Autor

Documentação criada para estudo, consulta rápida e domínio do ecossistema Airflow + AWS + EKS + APIs + Observabilidade.


