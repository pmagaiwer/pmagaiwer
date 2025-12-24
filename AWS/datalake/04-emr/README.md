# Amazon EMR

## Visão Geral

Amazon EMR é usado para processamento distribuído pesado (Spark, Hive, Presto).

## Métricas Importantes
- YARN Memory Utilization
- HDFS Used Space
- Failed Steps
- Cluster Uptime

## SLI / SLO
**SLI:**
- % de steps bem-sucedidos
- Tempo de processamento por job

**SLO:**
- 99% dos steps sem falha
- Jobs críticos < X horas

## Boas Práticas
- EMR ephemeral (cria → processa → termina)
- Auto Scaling
- Spot Instances
- Logs centralizados no S3

## Terraform – Boas Práticas
```hcl
resource "aws_emr_cluster" "cluster" {
  name          = "etl-emr"
  release_label = "emr-6.15.0"
  applications  = ["Spark"]
}
```