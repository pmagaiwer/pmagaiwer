# Monorepo vs Multi-repo para SRE com Terraform no Bitbucket

## Monorepo

**Definição:** Um único repositório centralizado para todos os códigos de automação, módulos e projetos Terraform.

### Vantagens
- **Padronização:** Reutilização de módulos e padrões entre projetos.
- **Visibilidade:** Equipe tem visão global de todas as automações e recursos.
- **Refatoração:** Mudanças em módulos compartilhados são aplicadas a todos os projetos de uma vez.
- **CI/CD centralizado:** Pipelines e políticas de qualidade unificados.

### Desvantagens
- **Escalabilidade:** Repositório pode crescer demais, dificultando o gerenciamento.
- **Conflitos:** Mais conflitos de merge, especialmente com times grandes.
- **Permissões:** Difícil restringir acesso a partes específicas do código.
- **Deploys acoplados:** Mudanças pequenas podem disparar pipelines para múltiplos projetos.

---

## Multi-repo

**Definição:** Cada projeto, conta ou automação tem seu próprio repositório separado.

### Vantagens
- **Isolamento:** Mudanças em um projeto não afetam outros.
- **Permissões granulares:** Fácil limitar acesso por projeto ou conta.
- **Deploys independentes:** Pipelines e releases são isolados.
- **Escalabilidade:** Repositórios menores, builds mais rápidos.

### Desvantagens
- **Duplicidade:** Possível duplicação de código e módulos.
- **Padronização difícil:** Mais difícil garantir padrões entre projetos.
- **Gestão de dependências:** Atualizar módulos compartilhados exige PRs em vários repositórios.
- **Visibilidade fragmentada:** Difícil ter visão global de tudo que está sendo automatizado.

---

## Considerações para múltiplas contas/projetos

- **Monorepo:**
  - Mais fácil garantir consistência entre contas/projetos.
  - Pode ser difícil separar segredos e variáveis sensíveis.
  - CI/CD precisa ser bem segmentado para evitar deploys acidentais.

- **Multi-repo:**
  - Permite separar automações por conta/projeto, facilitando governança.
  - Mais fácil aplicar políticas de segurança e compliance específicas.
  - Pode aumentar o esforço de manutenção de módulos comuns.

---

## Resumindo
- **Monorepo:** Melhor para times pequenos/médios, foco em padronização e reuso.
- **Multi-repo:** Melhor para times grandes, múltiplas contas, necessidades de isolamento e governança.

