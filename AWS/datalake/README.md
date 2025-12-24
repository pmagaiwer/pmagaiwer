# 📊 AWS Data Lake – Visão Geral e Guia Prático

## 📌 O que é um Data Lake?

Um **Data Lake** é uma arquitetura projetada para armazenar, processar e analisar grandes volumes de dados **estruturados, semi-estruturados e não estruturados**, mantendo os dados em seu formato original ou refinado conforme necessário.

Na AWS, o Data Lake é construído de forma **serverless, escalável e segura**, permitindo ingestão contínua, processamento sob demanda e consumo por múltiplos perfis (Data Science, BI, Engenharia e SRE).

---

## 🎯 Objetivos de um Data Lake

- Centralizar dados de múltiplas fontes
- Separar ingestão, processamento e consumo
- Garantir governança e segurança
- Escalar com baixo custo
- Permitir análises avançadas e BI

---

## 🧱 Arquitetura de um Data Lake na AWS

### Serviços Principais

| Camada | Serviço |
|------|--------|
| Armazenamento | Amazon S3 |
| Catálogo | AWS Glue Data Catalog |
| Processamento | AWS Glue / Amazon EMR |
| Consulta | Amazon Athena |
| Governança | AWS Lake Formation |
| Visualização | Amazon QuickSight |
| Segurança | IAM, KMS |
| Observabilidade | CloudWatch |

---

## 🏗️ Exemplo de Arquitetura (Visão Lógica)
```bash
    ┌────────────┐
    │  Fontes    │
    │ (Apps, DB) │
    └─────┬──────┘
          │
    ┌─────▼──────┐
    │  S3 - RAW  │
    │ dados brutos│
    └─────┬──────┘
          │
  ┌───────▼────────┐
  │ Glue / EMR ETL │
  │ limpeza/enrich │
  └───────┬────────┘
          │
    ┌─────▼──────┐
    │ S3 - CURATED│
    │ dados prontos│
    └─────┬──────┘
          │
┌──────────▼──────────┐
│ Glue Data Catalog │
└──────────┬──────────┘
         │
┌──────────▼──────────┐
│ Amazon Athena │
└──────────┬──────────┘
            │
┌─────▼──────┐
│ QuickSight │
│ Dashboards │
└────────────┘
```

---

## 🗂️ Organização de Dados no S3

Estrutura recomendada:
```bash
s3://company-datalake/
├── raw/
│ ├── system_a/
│ └── system_b/
├── processed/
│ ├── cleansed/
│ └── enriched/
└── curated/
├── analytics/
└── bi/
```

### Conceito das camadas
- **RAW**: dados como chegaram da origem
- **PROCESSED**: dados tratados e normalizados
- **CURATED**: dados prontos para consumo

---

## 🧪 Exemplo Prático de Uso

### Cenário
Uma empresa deseja analisar **vendas e comportamento de clientes**.

### Fluxo
1. Aplicações enviam dados para `s3://datalake/raw/`
2. Glue Crawlers catalogam os dados
3. Glue Jobs processam e escrevem em `processed/`
4. Dados refinados são salvos em `curated/`
5. Athena consulta os dados via SQL
6. QuickSight cria dashboards para o time de BI

---

## 🔐 Governança e Acesso

### Estratégia recomendada
- **IAM Roles**, nunca usuários
- **Lake Formation** controla acesso por:
  - Database
  - Tabela
  - Coluna
- **QuickSight não acessa S3 diretamente**

### Exemplo de acesso por persona

| Persona | Acesso |
|------|------|
| Data Scientist | Leitura em curated |
| BI | Views via Athena |
| Engenharia | RAW + PROCESSED |
| SRE | Infra e observabilidade |

---

## 📈 Observabilidade e Confiabilidade

### Métricas importantes
- S3: erros 4xx/5xx, latência
- Glue: jobs com falha
- Athena: tempo de query
- QuickSight: tempo de carregamento

### SLIs / SLOs (exemplo)
- Disponibilidade: **99.9%**
- Queries Athena: p95 < 30s
- Jobs Glue: 99% de sucesso

---

## 🏗️ Infraestrutura como Código (IaC)

Toda a infraestrutura deve ser criada via **Terraform**:

- Buckets S3
- IAM Roles
- Glue Jobs
- Athena Workgroups
- Lake Formation permissions
- CloudWatch dashboards

Benefícios:
- Reprodutibilidade
- Auditoria
- Controle de mudanças
- Ambientes separados (dev/stg/prod)

---

## ✅ Boas Práticas

- Particionar dados por data (`year/month/day`)
- Usar formatos colunares (Parquet)
- Criptografia com KMS
- Controle de custos com Athena Workgroups
- EMR efêmero
- Dashboards e alarmes desde o início

---

## 📚 Referências

- AWS Well-Architected – Analytics
- AWS Lake Formation Best Practices
- AWS Glue Documentation
- Amazon Athena Best Practices

---

## 🚀 Conclusão

Um Data Lake bem implementado na AWS permite:
- Escala
- Segurança
- Governança
- Observabilidade
- Flexibilidade para múltiplos times

Este repositório serve como **base de referência** para construção e operação de um Data Lake moderno.

---


flowchart TB
    subgraph Sources["Fontes de Dados"]
        A1["Aplicações"]
        A2["Bancos de Dados"]
        A3["APIs Externas"]
        A4["Arquivos Batch"]
    end

    subgraph Ingestion["Ingestão"]
        B1["EventBridge"]
        B2["AWS DMS"]
        B3["AWS Transfer"]
    end

    subgraph Storage["Data Lake - Amazon S3"]
        C1["RAW Zone"]
        C2["PROCESSED Zone"]
        C3["CURATED Zone"]
    end

    subgraph Processing["Processamento"]
        D1["AWS Glue Jobs"]
        D2["Amazon EMR (Spark)"]
    end

    subgraph Catalog["Catálogo e Governança"]
        E1["Glue Data Catalog"]
        E2["Lake Formation"]
    end

    subgraph Analytics["Consumo e Analytics"]
        F1["Amazon Athena"]
        F2["Amazon QuickSight"]
        F3["Data Science / ML"]
    end

    subgraph Observability["Observabilidade"]
        G1["Amazon CloudWatch"]
        G2["CloudWatch Alarms"]
    end

    A1 --> B1 --> C1
    A2 --> B2 --> C1
    A3 --> B1 --> C1
    A4 --> B3 --> C1

    C1 --> D1 --> C2
    C2 --> D2 --> C3

    C1 --> E1
    C2 --> E1
    C3 --> E1

    E2 --> E1

    C3 --> F1 --> F2
    C3 --> F3

    D1 --> G1
    D2 --> G1
    F1 --> G1
    G1 --> G2









```bash
```