# Terraform Repository Template

Este repositório fornece um template simples para organizar módulos Terraform, pipelines de CI/CD e exemplos de uso de um módulo padrão de tags obrigatórias.

## Índice

- [Estrutura do repositório](#estrutura-do-repositório)
- [Visão geral](#visão-geral)
- [Módulo padrão: `modules/base-tags`](#módulo-padrão-modulesbase-tags)
- [Exemplo de uso](#exemplo-de-uso)
- [CI/CD (Jenkins / Pipelines)](#cicd-jenkins--pipelines)
- [Boas práticas e dicas](#boas-práticas-e-dicas)
- [Referências](#referências)

## Estrutura do repositório

```
terraform-repo/
├── modules/
│   └── base-tags/
│       ├── main.tf
│       └── variables.tf
├── pipelines/
│   └── cicd-pipeline.yml
├── Jenkinsfile
└── README.md
```

## Visão geral

- Template de um módulo Terraform que garante tags obrigatórias.
- Exemplo de integração com Jenkins e SonarQube.
- Pipeline CI/CD genérico em YAML.

## Módulo padrão: `modules/base-tags`

O módulo `base-tags` centraliza a validação e a montagem das tags obrigatórias para recursos.

### Variáveis principais (exemplos)

```hcl
variable "CostString" {
  type        = string
  description = "Centro de custo no formato 1234.CC.123.123456"
}

variable "AppID" {
  type        = string
  description = "Identificador único da aplicação"
}

variable "AppIDs" {
  type        = list(string)
  description = "Lista de aplicações relacionadas"
  default     = []
}

variable "Environment" {
  type        = string
  description = "Ambiente da aplicação (prd, dev, sbc, hml, qa)"
  validation {
    condition     = contains(["prd", "dev", "sbc", "hml", "qa"], var.Environment)
    error_message = "Environment deve ser um de: prd, dev, sbc, hml, qa."
  }
}

variable "CreatedBy" {
  type        = string
  description = "Email do criador do recurso"
}

variable "CreatedOn" {
  type        = string
  description = "Timestamp de criação"
}
```

### Exemplo de `main.tf` do módulo

```hcl
locals {
  mandatory_tags = {
    CostString = var.CostString
    AppID      = var.AppID
    AppIDs     = length(var.AppIDs) > 0 ? join(",", var.AppIDs) : ""
    Environment = var.Environment
    CreatedBy  = var.CreatedBy
    CreatedOn  = var.CreatedOn
  }
}

output "tags" {
  value = local.mandatory_tags
}
```

## Exemplo de uso do módulo

```hcl
module "tags" {
  source      = "./modules/base-tags"
  CostString  = "1234.CC.123.123456"
  AppID       = "12345"
  AppIDs      = ["12345", "23456"]
  Environment = "prd"
  CreatedBy   = "user@email"
  CreatedOn   = "2025-12-05T20:15:21.059Z"
}

resource "aws_s3_bucket" "example" {
  bucket = "exemplo-padrao-terraform"

  tags = merge(
    module.tags.tags,
    {
      Name = "bucket-exemplo"
    }
  )
}
```

## CI/CD (Jenkins / Pipelines)

- Este repositório inclui um `Jenkinsfile` e um pipeline YAML de exemplo em `pipelines/cicd-pipeline.yml`.
- Recomenda-se integrar `terraform fmt`, `terraform validate` e análise estática (ex: `tfsec`) no pipeline.
- Se usar SonarQube: executar a análise do código fonte e aplicar um Quality Gate para bloquear merges quando necessário.

## Boas práticas e dicas

- Use módulos para padronizar recursos e tags.
- Valide variáveis com `validation` para evitar inputs inválidos.
- Mantenha os pipelines idempotentes e com agentes isolados (Docker).
- Não exponha segredos — use variáveis de ambiente seguras / secret managers.

## Referências

- Jenkins: https://www.jenkins.io/doc/
- SonarQube: https://docs.sonarsource.com/sonarqube/
- Terraform docs: https://www.terraform.io/docs
- Linux docs (comandos úteis): https://man7.org/linux/man-pages/

---

Se quiser, eu posso:

- Adicionar um exemplo de pipeline completo (Jenkinsfile) integrando SonarQube.
- Gerar um `tfsec`/`tflint` config básico.

Diga o que prefere que eu adicione a seguir.
# Terraform Repository Template

## 📁 Estrutura de Pastas
```
terraform-repo/
├── modules/
│   └── base-tags/
│       ├── main.tf
│       └── variables.tf
├── pipelines/
│   └── cicd-pipeline.yml
├── Jenkinsfile
└── README.md
```

## 🚀 Conteúdos Inclusos
- Template completo de módulo Terraform com tags obrigatórias
- Jenkinsfile com integração SonarQube + Terraform
- Pipeline CI/CD genérico via YAML


✅ 1. Padrão de Tags Obrigatórias – Terraform

Recomenda-se definir um bloco de validação dentro do módulo, garantindo que cada recurso possua as tags obrigatórias.

Tags obrigatórias
Tag	Descrição	Exemplo
CostString	Centro de custo em formato padrão	1234.CC.123.123456
AppID	Identificador de uma aplicação	12345
AppIDs	Lista de aplicações	12345,23456,34567,456789
Environment	Ambiente da infraestrutura	prd, dev, sbc
CreatedBy	Criador do recurso	user@email
CreatedOn	Data de criação	2025-12-05T20:15:21.059Z
✅ 2. Módulo Terraform Padrão (template)

Crie um módulo modules/base-tags/ com validações + merge automático de tags:

modules/base-tags/variables.tf
variable "CostString" {
  type        = string
  description = "Custos no padrão 1234.CC.123.123456"
}

variable "AppID" {
  type        = string
  description = "Identificador único da aplicação"
}

variable "AppIDs" {
  type        = list(string)
  description = "Lista de aplicações relacionadas"
  default     = []
}

variable "Environment" {
  type        = string
  description = "Ambiente da aplicação"
  validation {
    condition     = contains(["prd", "dev", "sbc", "hml", "qa"], var.Environment)
    error_message = "Environment deve ser um de: prd, dev, sbc, hml, qa."
  }
}

variable "CreatedBy" {
  type        = string
  description = "Email do criador do recurso"
}

variable "CreatedOn" {
  type        = string
  description = "Timestamp de criação"
}

modules/base-tags/main.tf
locals {
  mandatory_tags = {
    CostString = var.CostString
    AppID      = var.AppID
    AppIDs     = join(",", var.AppIDs)
    Environment = var.Environment
    CreatedBy  = var.CreatedBy
    CreatedOn  = var.CreatedOn
  }
}

output "tags" {
  value = local.mandatory_tags
}

✅ 3. Exemplo de uso do módulo em qualquer recurso

Aqui um exemplo criando um S3 usando o módulo:

main.tf
module "tags" {
  source      = "./modules/base-tags"
  CostString  = "1234.CC.123.123456"
  AppID       = "12345"
  AppIDs      = ["12345", "23456"]
  Environment = "prd"
  CreatedBy   = "user@email"
  CreatedOn   = "2025-12-05T20:15:21.059Z"
}

resource "aws_s3_bucket" "example" {
  bucket = "exemplo-padrao-terraform"

  tags = merge(
    module.tags.tags,
    {
      Name = "bucket-exemplo"
    }
  )
}

✅ 4. Resumo das Ferramentas + Dicas + Links Oficiais

Abaixo um resumo enxuto para colocar no README do repositório.

JENKINS

O que é:
Ferramenta de CI/CD altamente configurável, usada para automatizar pipelines de build, testes e deploy.

Como funciona:

Pipelines podem ser declarativos (Jenkinsfile)

Possui centenas de plugins

Roda em servidor próprio (local, VM ou container)

Dicas úteis:

Sempre usar pipelines declarativos (mais padronizados)

Utilizar agentes isolados com Docker

Evitar instalar plugins desnecessários

Documentação:
https://www.jenkins.io/doc/

NENUX (provavelmente Linux / ambiente UNIX)

(Se você quis dizer algo específico como “Nexus” me avise — mas “Nenux” costuma ser erro de digitação de “Linux”)

Linux / Unix

O que é:
Sistema operacional base para 90% dos ambientes cloud, CI/CD e infra moderna.

Como funciona:

Arquitetura simples, baseada em processos

Automação via shell (bash, zsh, sh)

Uso frequente em servidores, containers e pipelines

Dicas úteis:

Aprenda bem comandos básicos: ls, grep, awk, sed, tail, journalctl

Scripts shell devem ser idempotentes

Permissões (chmod, chown) são fundamentais

Documentação:
https://ubuntu.com/server/docs

https://man7.org/linux/man-pages/

SONARQUBE

Ferramenta de análise de qualidade e segurança de código.

Como funciona:

Analisa código em busca de bugs, vulnerabilidades e más práticas

Conecta-se a pipelines (ex: Jenkins)

Gera métricas: Coverage, Code Smells, Security Hotspots

Dicas úteis:

Definir quality gates obrigatórios no CI

Não aprovar PRs sem análise do Sonar

Integrar com GitHub/GitLab para comentários automáticos

Documentação:
https://docs.sonarsource.com/sonarqube/

APACHE AIRFLOW

Orquestrador de workflows (ETL, pipelines de dados, automações complexas).

Como funciona:

DAGs (Directed Acyclic Graphs) definem tarefas e dependências

Escrita em Python

Scheduler + Workers executam pipelines

Dicas úteis:

Manter DAGs pequenos e modulares

Usar variáveis e connections do Airflow para segredos

Monitorar SLAs e falhas com alertas

Documentação: