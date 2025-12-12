# 📘 README — Guia Operacional Airflow + EKS + Terraform (<project>)

Este documento resume todo o funcionamento da esteira CI/CD, operação do Airflow em EKS, práticas de troubleshooting, guia de estudos e um passo a passo real de como uma mudança no SQS é aplicada. Ideal para onboardings, suporte nível SR e referência rápida.

---

# 🧭 1. Fluxograma da Esteira (CI/CD)

```
                 ┌─────────────────────────┐
                 │      Desenvolvedor       │
                 └─────────────┬───────────┘
                               │
                               ▼
                   (1) Commit / Pull Request
                               │
                               ▼
                 ┌─────────────────────────┐
                 │        Bitbucket         │
                 └───────┬─────────┬───────┘
                         │         │
                         │         └─► Revisor aprova PR (UAT / PROD)
                         │
                         ▼
                 ┌─────────────────────────┐
                 │         Jenkins          │
                 └───────┬─────────────────┘
                         │
             ┌───────────┼──────────────────────────────┐
             │           │                              │
             ▼           ▼                              ▼
   (2) terraform init   terraform plan           Notifica resultado
             │
             ▼
   (3) Aprovação manual (se for UAT/Prod)
             │
             ▼
   (4) terraform apply  ──────────────────────────────► AWS
                                                           │
                                                           ▼
                                                Recursos atualizados
                                         (EKS, SQS, RDS, VPC, IAM, S3 etc.)
                                                           │
                                                           ▼
                                         ┌────────────────────────────┐
                                         │ Airflow executa no EKS     │
                                         │ DAGs sincronizam/deployam  │
                                         └────────────────────────────┘
```

---

# ☸️ 2. Guia Prático — Operando o Airflow no EKS via Lens/Freelens

## **Acesso ao Cluster**
- Abra o Freelens
- Vá em **Clusters**
- Selecione: `eks-<project>-dev`, `eks-<project>-uat` ou `eks-<project>-prod`
- Conecte

## **Namespaces Importantes**
- `airflow` — webserver, scheduler, workers
- `kube-system` — nodes e add-ons
- `observability` — logs/monitoramento (se houver)

## **Componentes Airflow no K8s**
- **webserver** → Interface do Airflow
- **scheduler** → Orquestra DAGs
- **worker** → Executa tasks

## **Reiniciar pods sem derrubar o cluster**
1. No Lens, vá em **Workloads → Pods**
2. Escolha o pod (ex: `scheduler`)
3. Delete → O Deployment recria automaticamente

## **Logs**
- Lens → Pod → Logs
- Airflow UI → Log da task
- CloudWatch (se configurado)

## **DAG não sincroniza?**
Checklist:
- Reiniciar scheduler
- Reiniciar webserver
- Validar se o git-sync/PVC montou as DAGs

---

# 🩺 3. Checklist de Erros no Airflow

## **1. DAG não aparece**
- Scheduler travado
- Erro no código da DAG
- Problema no git-sync ou PVC

## **2. Task travada em "queued"**
- Workers insuficientes
- Nodegroup sem recurso
- Executor com erro

## **3. Worker CrashLoopBackOff**
- Falta permissão IAM (IRSA)
- Imagem quebrada
- Problema no entrypoint da task

## **4. Erros de permissão na AWS**
- Role não está associada ao ServiceAccount
- Policy incorreta

## **5. DAG falha imediatamente**
- Connection incorreta
- Variable ausente
- Secret quebrado

## **6. Cluster lento**
- Falta node
- Workers consumindo CPU/memória
- HPA desativado

---

# 🎓 4. Guia de Estudos — O Caminho para Ficar Sênior

## **Terraform**
- https://developer.hashicorp.com/terraform/docs
- Estudar:
  - Modules
  - State remoto (S3 + DynamoDB)
  - Workspaces
  - lifecycle
  - import/taint/replace

## **AWS (foco)**
- EKS: https://docs.aws.amazon.com/eks/latest/userguide/
- SQS: https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/
- IAM: https://docs.aws.amazon.com/IAM/latest/UserGuide/
- Aurora: https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/

## **Kubernetes**
- https://kubernetes.io/docs/home/
- Dominar:
  - Deployments
  - ConfigMaps / Secrets
  - ServiceAccount + IRSA
  - HPA
  - PV/PVC

## **Airflow**
- https://airflow.apache.org/docs/
- Entender bem:
  - Scheduler
  - Executors (KubernetesExecutor/CeleryK8s)
  - Connections/Variables
  - Logs

## **Jenkins**
- https://www.jenkins.io/doc/book/pipeline/
- Entender BlueOcean ou pipelines declarativos

## **Bitbucket**
- PRs
- Branch restriction
- Webhooks para Jenkins

---

# 📦 5. Exemplo real — Como o SQS foi alterado (de 2k para 200k)

## **PASSO 1 — Ajuste no módulo SRE (se necessário)**
Arquivo: `modules/sqs/variables.tf`

```hcl
variable "max_message_size" {
  type    = number
  default = 200000
}
```

## **PASSO 2 — Ajuste no repo da conta**
Arquivo: `infra/sqs.tf`

```hcl
max_message_size = 200000
```

## **PASSO 3 — PR no Bitbucket**
- CI roda `terraform plan`
- Exibe diff da alteração

## **PASSO 4 — Aprovação**
- Dev — automático
- UAT — exige aprovação
- Prod — aprovação + permissão

## **PASSO 5 — Jenkins aplica**
```
terraform apply
~ max_message_size: "2000" => "200000"
```

## **PASSO 6 — AWS atualiza o recurso**
Tudo aplicado via IaC com controle total.

---

# 📂 Sugestão de pasta no Git

Crie uma pasta dedicada dentro do repositório SRE ou do repositório da conta:

```
docs/
   airflow-eks-guide/
      README.md
      fluxograma.png   (se quiser adicionar depois)
      troubleshooting.md
      estudos.md
```

Ou, se for para centralizar governança no time SRE:

```
sre-knowledge-base/
   airflow/
   eks/
   terraform/
   ci-cd/
```

---

Se quiser, posso também gerar esse README como **PDF** ou criar arquivos separados dentro dessa pasta para você mover direto para o Git.

