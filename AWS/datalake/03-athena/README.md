# AWS Athena

## Visão Geral

Athena permite consulta SQL serverless sobre dados no S3 usando Glue Catalog.

## Métricas Importantes
- ProcessedBytes
- QueryExecutionTime
- QueryFailedCount

## SLI / SLO
**SLI:**
- Taxa de sucesso das queries
- Tempo médio de execução
- Bytes processados por query

**SLO:**
- 99.5% das queries com sucesso
- p95 < 30s para queries padrão

## Acesso
- Usuários via IAM + Lake Formation
- QuickSight acessa via Athena
- Workgroups para controle de custo

## Terraform – Boas Práticas
```hcl
resource "aws_athena_workgroup" "wg" {
  name = "analytics"
  configuration {
    enforce_workgroup_configuration = true
    publish_cloudwatch_metrics_enabled = true
  }
}
```