# Amazon QuickSight

## Visão Geral

QuickSight é a camada de visualização e BI.

## Métricas Importantes
- Dashboard Load Time
- Failed Queries
- SPICE Capacity Usage

## SLI / SLO
**SLI:**
- Tempo de carregamento de dashboards
- Taxa de erro de visualização

**SLO:**
- p95 < 5s para dashboards
- 99.9% de disponibilidade

## Acesso
- Autenticação via IAM / SSO
- Sem acesso direto ao S3
- Sempre via Athena ou Redshift

## Boas Práticas
- Usar SPICE para performance
- Views no Athena
- Governança via Lake Formation
