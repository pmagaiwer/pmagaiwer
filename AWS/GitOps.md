# Principais Comandos Git (GitOps)

## 1. Configuração Inicial
```bash
git config --global user.name "Seu Nome"
git config --global user.email "seu@email.com"
```

## 2. Clonar Repositório
```bash
git clone <url-do-repositorio>
```

## 3. Status dos Arquivos
```bash
git status
```

## 4. Adicionar Arquivos
```bash
git add <arquivo>
# Ou todos os arquivos
git add .
```

## 5. Commitar Mudanças
```bash
git commit -m "Mensagem do commit"
```

## 6. Criar Branch
```bash
git branch <nome-da-branch>
# Ou já trocar para ela
git checkout -b <nome-da-branch>
```

## 7. Trocar de Branch
```bash
git checkout <nome-da-branch>
```

## 8. Listar Branches
```bash
git branch
```

## 9. Deletar Branch
- Local:
```bash
git branch -d <nome-da-branch>
# Forçar exclusão
git branch -D <nome-da-branch>
```
- Remoto:
```bash
git push origin --delete <nome-da-branch>
```

## 10. Atualizar Branch Local com Remoto
```bash
git pull origin <nome-da-branch>
```

## 11. Enviar Branch para o Remoto
```bash
git push origin <nome-da-branch>
```

## 12. Mesclar Branchs (Merge)
```bash
git checkout <branch-destino>
git merge <branch-origem>
```

## 13. Resolver Conflitos
- Edite os arquivos conflitantes, depois:
```bash
git add <arquivo-resolvido>
git commit
```

## 14. Histórico de Commits
```bash
git log
```

## 15. Reverter Commit
```bash
git revert <hash-do-commit>
```

## 16. Resetar Branch para Estado de Outra
```bash
git reset --hard <branch-ou-hash>
```

---

## Exemplo de Fluxo Completo
1. Criar branch:
   ```bash
   git checkout -b minha-feature
   ```
2. Adicionar arquivos:
   ```bash
   git add .
   ```
3. Commitar:
   ```bash
   git commit -m "Implementa minha feature"
   ```
4. Enviar para remoto:
   ```bash
   git push origin minha-feature
   ```
5. Mesclar na main:
   ```bash
   git checkout main
   git pull origin main
   git merge minha-feature
   git push origin main
   ```
6. Deletar branch:
   ```bash
   git branch -d minha-feature
   git push origin --delete minha-feature
   ```

---

> Este arquivo serve como referência rápida para comandos essenciais do Git em fluxos GitOps.