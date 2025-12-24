📁 01 – s3-data-lake.md

# Data Lake no Amazon S3

## Visão Geral

O Amazon S3 é a base do Data Lake, responsável por armazenar dados **raw**, **processed** e **curated** com alta durabilidade e baixo custo.

### Arquitetura comum

```
s3://datalake/
 ├── raw/
 ├── processed/
 └── curated/
```

## Métricas Importantes (CloudWatch)

**Técnicas:**

- BucketSizeBytes
- NumberOfObjects
- 4xxErrors
- 5xxErrors
- FirstByteLatency
- TotalRequestLatency

## Exemplos de SLI / SLO

**SLI:**
- % de requisições GET/PUT bem-sucedidas
- Latência p95 de leitura de objetos
- Taxa de erros 5xx

**SLO (exemplo):**
- Disponibilidade: 99.9% de sucesso em requisições
- Latência: p95 < 200ms para objetos < 128MB

## Acesso e Segurança

**Boas práticas:**
- Nunca acesso público
- Uso de IAM Roles, não usuários
- Bucket Policies + IAM
- SSE-KMS habilitado
- Versionamento ativo
- Object Lock (opcional)

## Exemplo de acesso

- Glue: leitura em raw/
- EMR: leitura/escrita em processed/
- Athena: leitura em curated/
- QuickSight: acesso via Athena

## Terraform – Boas Práticas

```hcl
resource "aws_s3_bucket" "datalake" {
  bucket = "company-datalake-prod"
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.datalake.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "sse" {
  bucket = aws_s3_bucket.datalake.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.datalake.arn
      sse_algorithm     = "aws:kms"
    }
  }
}
```

📁 02 – glue.md
Visão Geral

AWS Glue é o motor de catalogação, ETL e metadados do Data Lake.

Componentes

Glue Data Catalog

Crawlers

Jobs (Spark / Python)

Workflows

Métricas Importantes

glue.driver.aggregate.elapsedTime

glue.executor.aggregate.cpuTime

glue.jobs.failed

glue.jobs.succeeded

SLI / SLO
SLI

Taxa de sucesso dos jobs

Tempo médio de execução

Freshness do catálogo

SLO

99% dos jobs finalizam com sucesso

Tempo de execução < X minutos (por job crítico)

Catálogo atualizado em até 30 min após ingestão

Acesso

Jobs executam com IAM Role

Permissões mínimas:

S3 read/write

Glue Catalog

Logs (CloudWatch)

Terraform – Boas Práticas
resource "aws_glue_catalog_database" "db" {
  name = "datalake_curated"
}

resource "aws_glue_job" "etl" {
  name     = "etl-curated"
  role_arn = aws_iam_role.glue.arn
  command {
    script_location = "s3://scripts/etl.py"
  }
}

📁 03 – athena.md
Visão Geral

Athena permite consulta SQL serverless sobre dados no S3 usando Glue Catalog.

Métricas Importantes

ProcessedBytes

QueryExecutionTime

QueryFailedCount

SLI / SLO
SLI

Taxa de sucesso das queries

Tempo médio de execução

Bytes processados por query

SLO

99.5% das queries com sucesso

p95 < 30s para queries padrão

Acesso

Usuários via IAM + Lake Formation

QuickSight acessa via Athena

Workgroups para controle de custo

Terraform – Boas Práticas
resource "aws_athena_workgroup" "wg" {
  name = "analytics"
  configuration {
    enforce_workgroup_configuration = true
    publish_cloudwatch_metrics_enabled = true
  }
}

📁 04 – emr.md
Visão Geral

Amazon EMR é usado para processamento distribuído pesado (Spark, Hive, Presto).

Métricas Importantes

YARN Memory Utilization

HDFS Used Space

Failed Steps

Cluster Uptime

SLI / SLO
SLI

% de steps bem-sucedidos

Tempo de processamento por job

SLO

99% dos steps sem falha

Jobs críticos < X horas

Boas Práticas

EMR ephemeral (cria → processa → termina)

Auto Scaling

Spot Instances

Logs centralizados no S3

Terraform – Boas Práticas
resource "aws_emr_cluster" "cluster" {
  name          = "etl-emr"
  release_label = "emr-6.15.0"
  applications  = ["Spark"]
}

📁 05 – lake-formation.md
Visão Geral

Lake Formation gerencia governança, segurança e acesso aos dados.

Funcionalidades

Controle fino por tabela/coluna

Integração com Athena, Glue, Redshift

Centralização de permissões

Métricas Importantes

Access Denied Events

Policy Evaluation Latency

SLI / SLO
SLI

% de acessos autorizados corretamente

Tempo de avaliação de políticas

SLO

100% de acessos auditáveis

Latência de autorização < 100ms

Acesso (Exemplo)

Time Data Science: leitura em curated

BI: acesso apenas via views

Engenharia: acesso total controlado

Terraform – Boas Práticas
resource "aws_lakeformation_permissions" "athena_access" {
  principal   = aws_iam_role.athena.arn
  permissions = ["SELECT"]
}

📁 06 – quicksight.md
Visão Geral

QuickSight é a camada de visualização e BI.

Métricas Importantes

Dashboard Load Time

Failed Queries

SPICE Capacity Usage

SLI / SLO
SLI

Tempo de carregamento de dashboards

Taxa de erro de visualização

SLO

p95 < 5s para dashboards

99.9% de disponibilidade

Acesso

Autenticação via IAM / SSO

Sem acesso direto ao S3

Sempre via Athena ou Redshift

Boas Práticas

Usar SPICE para performance

Views no Athena

Governança via Lake Formation

📁 Serviços adicionais recomendados

Crie também:

kms.md – criptografia

cloudwatch.md – observabilidade

iam.md – estratégia de acesso

step-functions.md – orquestração

eventbridge.md – eventos de ingestão