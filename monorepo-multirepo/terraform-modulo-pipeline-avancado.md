# Exemplo Avançado de Módulo Terraform e Pipeline Bitbucket

## Módulo Terraform: S3 Bucket

Estrutura:
```
modules/
  s3_bucket/
    main.tf
    variables.tf
    outputs.tf
```

**main.tf**
```hcl
resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
  acl    = var.acl
  tags   = var.tags
}
```

**variables.tf**
```hcl
variable "bucket_name" { type = string }
variable "acl"         { type = string  default = "private" }
variable "tags"        { type = map(string) default = {} }
```

**outputs.tf**
```hcl
output "bucket_arn" {
  value = aws_s3_bucket.this.arn
}
```

**Uso no projeto:**
```hcl
module "meu_bucket" {
  source      = "../../modules/s3_bucket"
  bucket_name = "meu-bucket-exemplo"
  tags = {
    Environment = "dev"
    Owner       = "SRE"
  }
}
```

---

## Pipeline Bitbucket Avançado

```yaml
image: hashicorp/terraform:1.5

pipelines:
  default:
    - step:
        name: "Lint Terraform"
        script:
          - terraform fmt -check -recursive
          - terraform validate
    - step:
        name: "Terraform Plan"
        script:
          - terraform init -backend-config="bucket=$TF_STATE_BUCKET"
          - terraform plan -out=tfplan
        artifacts:
          - tfplan
    - step:
        name: "Terraform Apply"
        trigger: manual
        script:
          - terraform init -backend-config="bucket=$TF_STATE_BUCKET"
          - terraform apply tfplan
```

**Dicas:**
- Use variáveis de ambiente ($TF_STATE_BUCKET) configuradas no Bitbucket.
- Adicione steps para lint/validate antes do plan/apply.
- Use artifacts para compartilhar o plano entre steps.
- Sempre mantenha o apply como manual para evitar execuções acidentais.
