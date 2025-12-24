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