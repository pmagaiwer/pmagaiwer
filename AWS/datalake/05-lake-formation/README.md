# AWS Lake Formation

## Visão Geral

Lake Formation gerencia governança, segurança e acesso aos dados.

## Funcionalidades
- Controle fino por tabela/coluna
- Integração com Athena, Glue, Redshift
- Centralização de permissões

## Métricas Importantes
- Access Denied Events
- Policy Evaluation Latency

## SLI / SLO
**SLI:**
- % de acessos autorizados corretamente
- Tempo de avaliação de políticas

**SLO:**
- 100% de acessos auditáveis
- Latência de autorização < 100ms

## Acesso (Exemplo)
- Time Data Science: leitura em curated
- BI: acesso apenas via views
- Engenharia: acesso total controlado

## Terraform – Boas Práticas
```hcl
resource "aws_lakeformation_permissions" "athena_access" {
  principal   = aws_iam_role.athena.arn
  permissions = ["SELECT"]
}
```