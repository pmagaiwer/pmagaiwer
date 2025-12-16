# Bitbucket Pipelines e Terraform: Exemplos e Recomendações

## Exemplo prático: Bitbucket Pipelines + Terraform

### Estrutura Monorepo

```
infra/
  ├─ modules/
  │    ├─ vpc/
  │    └─ s3/
  ├─ projetos/
  │    ├─ projeto-a/
  │    │    └─ main.tf
  │    └─ projeto-b/
  │         └─ main.tf
  └─ bitbucket-pipelines.yml
```

#### Exemplo de bitbucket-pipelines.yml (Monorepo)

```yaml
image: hashicorp/terraform:1.5

pipelines:
  default:
    - step:
        name: "Terraform Plan"
        script:
          - cd infra/projetos/projeto-a
          - terraform init
          - terraform plan
    - step:
        name: "Terraform Apply"
        trigger: manual
        script:
          - cd infra/projetos/projeto-a
          - terraform init
          - terraform apply -auto-approve
```

- Use variáveis de ambiente do Bitbucket para segredos.
- Separe pipelines por projeto usando paths diferentes.
- Use workspaces do Terraform para múltiplos ambientes.

---

### Estrutura Multi-repo

Cada projeto tem seu próprio repositório:

```
repo-projeto-a/
  ├─ modules/ (opcional)
  ├─ main.tf
  └─ bitbucket-pipelines.yml
```

#### Exemplo de bitbucket-pipelines.yml (Multi-repo)

```yaml
image: hashicorp/terraform:1.5

pipelines:
  default:
    - step:
        name: "Terraform Plan"
        script:
          - terraform init
          - terraform plan
    - step:
        name: "Terraform Apply"
        trigger: manual
        script:
          - terraform init
          - terraform apply -auto-approve
```

- Cada repositório tem seu pipeline e variáveis próprias.
- Atualizações em módulos compartilhados exigem PRs em todos os repositórios dependentes.

---

## Recomendações

- Sempre use variáveis de ambiente seguras para credenciais.
- Use backends remotos (ex: S3 + DynamoDB) para o state do Terraform.
- Implemente revisão manual para o apply.
- Use módulos para padronizar recursos.
- Em monorepo, segmente pipelines por pasta/projeto.
- Em multi-repo, mantenha um repositório separado para módulos compartilhados.

Se quiser um exemplo de módulo Terraform ou pipeline mais avançado, veja abaixo!
