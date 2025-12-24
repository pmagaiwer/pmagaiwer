# AWS Glue

## Visão Geral

AWS Glue é o motor de catalogação, ETL e metadados do Data Lake.

### Componentes
- Glue Data Catalog
- Crawlers
- Jobs (Spark / Python)
- Workflows

## Métricas Importantes
- glue.driver.aggregate.elapsedTime
- glue.executor.aggregate.cpuTime
- glue.jobs.failed
- glue.jobs.succeeded

## SLI / SLO
**SLI:**
- Taxa de sucesso dos jobs
- Tempo médio de execução
- Freshness do catálogo

**SLO:**
- 99% dos jobs finalizam com sucesso
- Tempo de execução < X minutos (por job crítico)
- Catálogo atualizado em até 30 min após ingestão

## Acesso
- Jobs executam com IAM Role
- Permissões mínimas:
  - S3 read/write
  - Glue Catalog
  - Logs (CloudWatch)

## Terraform – Boas Práticas
```hcl
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
```