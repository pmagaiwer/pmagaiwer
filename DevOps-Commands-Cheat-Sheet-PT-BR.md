# Guia de Referência Rápida - Comandos DevOps

## Comandos Básicos do Linux 

O Linux é a base das operações DevOps - é como um canivete suíço para servidores. Estes comandos ajudam você a navegar sistemas, gerenciar arquivos, configurar permissões e automatizar tarefas em ambientes de terminal.

1. **pwd** - Exibe o diretório de trabalho atual.
2. **ls** - Lista arquivos e diretórios.
3. **cd** - Muda de diretório.
4. **touch** - Cria um arquivo vazio.
5. **mkdir** - Cria um novo diretório.
6. **rm** - Remove arquivos ou diretórios.
7. **rmdir** - Remove diretórios vazios.
8. **cp** - Copia arquivos ou diretórios.
9. **mv** - Move ou renomeia arquivos e diretórios.
10. **cat** - Exibe o conteúdo de um arquivo.
11. **echo** - Exibe uma linha de texto.
12. **clear** - Limpa a tela do terminal.

## Comandos Intermediários do Linux

13. **chmod** - Altera permissões de arquivo.
14. **chown** - Altera propriedade de arquivo.
15. **find** - Busca por arquivos e diretórios.
16. **grep** - Busca por texto em um arquivo.
17. **wc** - Conta linhas, palavras e caracteres em um arquivo.
18. **head** - Exibe as primeiras linhas de um arquivo.
19. **tail** - Exibe as últimas linhas de um arquivo.
20. **sort** - Ordena o conteúdo de um arquivo.
21. **uniq** - Remove linhas duplicadas de um arquivo.
22. **diff** - Compara dois arquivos linha por linha.
23. **tar** - Arquiva arquivos em um tarball.
24. **zip/unzip** - Comprime e extrai arquivos ZIP.
25. **df** - Exibe uso do espaço em disco.
26. **du** - Exibe tamanho do diretório.
27. **top** - Monitora processos do sistema em tempo real.
28. **ps** - Exibe processos ativos.
29. **kill** - Termina um processo pelo seu PID.
30. **ping** - Verifica conectividade de rede.
31. **wget** - Baixa arquivos da internet.
32. **curl** - Transfere dados de ou para um servidor.
33. **scp** - Copia arquivos com segurança entre sistemas.
34. **rsync** - Sincroniza arquivos e diretórios.

## Comandos Avançados do Linux

35. **awk** - Processamento de texto e busca por padrões.
36. **sed** - Editor de fluxo para filtrar e transformar texto.
37. **cut** - Remove seções de cada linha de um arquivo.
38. **tr** - Traduz ou deleta caracteres.
39. **xargs** - Constrói e executa linhas de comando a partir da entrada padrão.
40. **ln** - Cria links simbólicos ou físicos.
41. **df -h** - Exibe uso do disco em formato legível.
42. **free** - Exibe uso da memória.
43. **iostat** - Exibe estatísticas de CPU e I/O.
44. **netstat** - Estatísticas de rede (use ss como alternativa moderna).
45. **ifconfig/ip** - Configura interfaces de rede (use ip como alternativa moderna).
46. **iptables** - Configura regras de firewall.
47. **systemctl** - Controla o gerenciador de sistema e serviços systemd.
48. **journalctl** - Visualiza logs do sistema.
49. **crontab** - Agenda tarefas recorrentes.
50. **at** - Agenda tarefas para um horário específico.
51. **uptime** - Exibe tempo de atividade do sistema.
52. **whoami** - Exibe o usuário atual.
53. **users** - Lista todos os usuários logados atualmente.
54. **hostname** - Exibe ou define o nome do sistema.
55. **env** - Exibe variáveis de ambiente.
56. **export** - Define variáveis de ambiente.

## Comandos de Rede

57. **ip addr** - Exibe ou configura endereços IP.
58. **ip route** - Mostra ou manipula tabelas de roteamento.
59. **traceroute** - Rastreia a rota que os pacotes fazem até um host.
60. **nslookup** - Consulta registros DNS.
61. **dig** - Consulta servidores DNS.
62. **ssh** - Conecta a um servidor remoto via SSH.
63. **ftp** - Transfere arquivos usando o protocolo FTP.
64. **nmap** - Varredura e descoberta de rede.
65. **telnet** - Comunica com hosts remotos.
66. **netcat (nc)** - Lê/escreve dados através de redes.

## Gerenciamento de Arquivos e Busca

67. **locate** - Encontra arquivos rapidamente usando um banco de dados.
68. **stat** - Exibe informações detalhadas sobre um arquivo.
69. **tree** - Exibe diretórios como uma árvore.
70. **file** - Determina o tipo de um arquivo.
71. **basename** - Extrai o nome do arquivo de um caminho.
72. **dirname** - Extrai a parte do diretório de um caminho.

## Monitoramento do Sistema

73. **vmstat** - Exibe estatísticas de memória virtual.
74. **htop** - Visualizador interativo de processos (alternativa ao top).
75. **lsof** - Lista arquivos abertos.
76. **dmesg** - Imprime mensagens do buffer do kernel.
77. **uptime** - Mostra há quanto tempo o sistema está rodando.
78. **iotop** - Exibe I/O de disco em tempo real por processos.

## Gerenciamento de Pacotes

79. **apt** - Gerenciador de pacotes para distribuições baseadas no Debian.
80. **yum/dnf** - Gerenciador de pacotes para distribuições baseadas no RHEL.
81. **snap** - Gerencia pacotes snap.
82. **rpm** - Gerencia pacotes RPM.

## Disco e Sistema de Arquivos

83. **mount/umount** - Monta ou desmonta sistemas de arquivos.
84. **fsck** - Verifica e repara sistemas de arquivos.
85. **mkfs** - Cria um novo sistema de arquivos.
86. **blkid** - Exibe informações sobre dispositivos de bloco.
87. **lsblk** - Lista informações sobre dispositivos de bloco.
88. **parted** - Gerencia partições interativamente.

## Script e Automação

89. **bash** - Interpretador de comandos e shell de script.
90. **sh** - Interpretador de shell legado.
91. **cron** - Automatiza tarefas.
92. **alias** - Cria atalhos para comandos.
93. **source** - Executa comandos de um arquivo no shell atual.

## Desenvolvimento e Depuração

94. **gcc** - Compila programas C.
95. **make** - Constrói e gerencia projetos.
96. **strace** - Rastreia chamadas de sistema e sinais.
97. **gdb** - Depura programas.
98. **git** - Sistema de controle de versão.
99. **vim/nano** - Editores de texto para scripts e edição.

## Outros Comandos Úteis

100. **uptime** - Exibe tempo de atividade do sistema.
101. **date** - Exibe ou define data e hora do sistema.
102. **cal** - Exibe um calendário.
103. **man** - Exibe o manual de um comando.
104. **history** - Mostra comandos executados anteriormente.
105. **alias** - Cria atalhos personalizados para comandos.

---

## Comandos Básicos do Git

O Git é sua máquina do tempo para código. Ele rastreia cada mudança, permite colaboração em equipe sem conflitos e deixa você desfazer erros. Estes comandos ajudam a gerenciar versões de código fonte como um desenvolvedor profissional.

### Inicialização e Configuração de Repositório

1. **git init**  
   Inicializa um novo repositório Git no diretório atual.  
   Exemplo: `git init`

2. **git clone**  
   Copia um repositório remoto para a máquina local.  
   Exemplo: `git clone https://github.com/usuario/repo.git`

3. **git config**  
   Configura definições do usuário, como nome e email.  
   Exemplo: `git config --global user.name "Seu Nome"`

### Operações Básicas do Repositório

4. **git status**  
   Exibe o estado do diretório de trabalho e área de staging.  
   Exemplo: `git status`

5. **git add**  
   Adiciona mudanças à área de staging.  
   Exemplo: `git add arquivo.txt`

6. **git commit**  
   Registra mudanças no repositório.  
   Exemplo: `git commit -m "Commit inicial"`

7. **git log**  
   Mostra o histórico de commits.  
   Exemplo: `git log`

8. **git show**  
   Exibe informações detalhadas sobre um commit específico.  
   Exemplo: `git show <hash-do-commit>`

9. **git diff**  
   Mostra mudanças entre commits, diretório de trabalho e área de staging.  
   Exemplo: `git diff`

10. **git reset**  
    Remove mudanças do staging ou redefine commits.  
    Exemplo: `git reset HEAD arquivo.txt`

### Ramificação e Fusão

11. **git branch**  
    Lista branches ou cria um novo branch.  
    Exemplo: `git branch feature-branch`

12. **git checkout**  
    Alterna entre branches ou restaura arquivos.  
    Exemplo: `git checkout feature-branch`

13. **git switch**  
    Alterna branches (alternativa moderna ao git checkout).  
    Exemplo: `git switch feature-branch`

14. **git merge**  
    Combina mudanças de um branch em outro.  
    Exemplo: `git merge feature-branch`

15. **git rebase**  
    Move ou combina commits de um branch para outro.  
    Exemplo: `git rebase main`

16. **git cherry-pick**  
    Aplica commits específicos de um branch para outro.  
    Exemplo: `git cherry-pick <hash-do-commit>`

### Repositórios Remotos

17. **git remote**  
    Gerencia conexões com repositórios remotos.  
    Exemplo: `git remote add origin https://github.com/usuario/repo.git`

18. **git push**  
    Envia mudanças para um repositório remoto.  
    Exemplo: `git push origin main`

19. **git pull**  
    Busca e mescla mudanças de um repositório remoto.  
    Exemplo: `git pull origin main`

20. **git fetch**  
    Baixa mudanças de um repositório remoto sem mesclar.  
    Exemplo: `git fetch origin`

21. **git remote -v**  
    Lista as URLs dos repositórios remotos.  
    Exemplo: `git remote -v`

### Stash e Limpeza

22. **git stash**  
    Salva temporariamente mudanças não commitadas.  
    Exemplo: `git stash`

23. **git stash pop**  
    Aplica mudanças stashadas e as remove da lista de stash.  
    Exemplo: `git stash pop`

24. **git stash list**  
    Lista todos os stashes.  
    Exemplo: `git stash list`

25. **git clean**  
    Remove arquivos não rastreados do diretório de trabalho.  
    Exemplo: `git clean -f`

### Tags

26. **git tag**  
    Cria uma tag para um commit específico.  
    Exemplo: `git tag -a v1.0 -m "Versão 1.0"`

27. **git tag -d**  
    Deleta uma tag.  
    Exemplo: `git tag -d v1.0`

28. **git push --tags**  
    Envia tags para um repositório remoto.  
    Exemplo: `git push origin --tags`

### Comandos Avançados

29. **git bisect**  
    Encontra o commit que introduziu um bug.  
    Exemplo: `git bisect start`

30. **git blame**  
    Mostra qual commit e autor modificou cada linha de um arquivo.  
    Exemplo: `git blame arquivo.txt`

31. **git reflog**  
    Mostra um log de mudanças no topo dos branches.  
    Exemplo: `git reflog`

32. **git submodule**  
    Gerencia repositórios externos como submódulos.  
    Exemplo: `git submodule add https://github.com/usuario/repo.git`

33. **git archive**  
    Cria um arquivo dos arquivos do repositório.  
    Exemplo: `git archive --format=zip HEAD > arquivo.zip`

34. **git gc**  
    Limpa arquivos desnecessários e otimiza o repositório.  
    Exemplo: `git gc`

### Comandos Específicos do GitHub

35. **gh auth login**  
    Faz login no GitHub via linha de comando.  
    Exemplo: `gh auth login`

36. **gh repo clone**  
    Clona um repositório do GitHub.  
    Exemplo: `gh repo clone usuario/repo`

37. **gh issue list**  
    Lista issues em um repositório do GitHub.  
    Exemplo: `gh issue list`

38. **gh pr create**  
    Cria um pull request no GitHub.  
    Exemplo: `gh pr create --title "Nova Funcionalidade" --body "Descrição da funcionalidade"`

39. **gh repo create**  
    Cria um novo repositório no GitHub.  
    Exemplo: `gh repo create meu-repo`

---

## Comandos Básicos do Docker

O Docker empacota aplicações em containers portáteis - como containers de transporte para software. Estes comandos ajudam a construir, enviar e executar aplicações de forma consistente em qualquer ambiente.

### Instalação e Informações do Docker

1. **docker --version**  
   Exibe a versão instalada do Docker.  
   Exemplo: `docker --version`

2. **docker info**  
   Mostra informações do sistema sobre o Docker, como número de containers e imagens.  
   Exemplo: `docker info`

### Gerenciamento de Imagens

3. **docker pull**  
   Baixa uma imagem de um registro Docker (padrão: Docker Hub).  
   Exemplo: `docker pull ubuntu:latest`

4. **docker images**  
   Lista todas as imagens baixadas.  
   Exemplo: `docker images`

5. **docker rmi**  
   Remove uma imagem.  
   Exemplo: `docker rmi nome_da_imagem`

6. **docker build**  
   Constrói uma imagem a partir de um Dockerfile.  
   Exemplo: `docker build -t minha_imagem .`

### Ciclo de Vida do Container

7. **docker run**  
   Cria e inicia um novo container a partir de uma imagem.  
   Exemplo: `docker run -it ubuntu bash`

8. **docker ps**  
   Lista containers em execução.  
   Exemplo: `docker ps`

9. **docker ps -a**  
   Lista todos os containers, incluindo os parados.  
   Exemplo: `docker ps -a`

10. **docker stop**  
    Para um container em execução.  
    Exemplo: `docker stop nome_do_container`

11. **docker start**  
    Inicia um container parado.  
    Exemplo: `docker start nome_do_container`

12. **docker rm**  
    Remove um container.  
    Exemplo: `docker rm nome_do_container`

13. **docker exec**  
    Executa um comando dentro de um container em execução.  
    Exemplo: `docker exec -it nome_do_container bash`

### Comandos Intermediários do Docker

14. **docker commit**  
    Cria uma nova imagem a partir das mudanças de um container.  
    Exemplo: `docker commit nome_do_container minha_imagem:tag`

15. **docker logs**  
    Busca logs de um container.  
    Exemplo: `docker logs nome_do_container`

16. **docker inspect**  
    Retorna informações detalhadas sobre um objeto (container ou imagem).  
    Exemplo: `docker inspect nome_do_container`

17. **docker stats**  
    Exibe estatísticas de uso de recursos de containers em execução.  
    Exemplo: `docker stats`

18. **docker cp**  
    Copia arquivos entre um container e o host.  
    Exemplo: `docker cp nome_do_container:/caminho/no/container /caminho/no/host`

19. **docker rename**  
    Renomeia um container.  
    Exemplo: `docker rename nome_antigo nome_novo`

### Redes

20. **docker network ls**  
    Lista todas as redes Docker.  
    Exemplo: `docker network ls`

21. **docker network create**  
    Cria uma nova rede Docker.  
    Exemplo: `docker network create minha_rede`

22. **docker network inspect**  
    Mostra detalhes sobre uma rede Docker.  
    Exemplo: `docker network inspect minha_rede`

23. **docker network connect**  
    Conecta um container a uma rede.  
    Exemplo: `docker network connect minha_rede nome_do_container`

### Gerenciamento de Volumes

24. **docker volume ls**  
    Lista todos os volumes Docker.  
    Exemplo: `docker volume ls`

25. **docker volume create**  
    Cria um novo volume Docker.  
    Exemplo: `docker volume create meu_volume`

26. **docker volume inspect**  
    Fornece detalhes sobre um volume.  
    Exemplo: `docker volume inspect meu_volume`

27. **docker volume rm**  
    Remove um volume Docker.  
    Exemplo: `docker volume rm meu_volume`

### Docker Compose

28. **docker-compose up**  
    Inicia serviços definidos em um arquivo docker-compose.yml.  
    Exemplo: `docker-compose up`

29. **docker-compose down**  
    Para e remove serviços definidos em um arquivo docker-compose.yml.  
    Exemplo: `docker-compose down`

30. **docker-compose logs**  
    Exibe logs para serviços gerenciados pelo Docker Compose.  
    Exemplo: `docker-compose logs`

31. **docker-compose exec**  
    Executa um comando no container de um serviço.  
    Exemplo: `docker-compose exec nome_do_servico bash`

### Importar/Exportar

32. **docker save**  
    Exporta uma imagem para um arquivo tar.  
    Exemplo: `docker save -o minha_imagem.tar minha_imagem:tag`

33. **docker load**  
    Importa uma imagem de um arquivo tar.  
    Exemplo: `docker load < minha_imagem.tar`

34. **docker export**  
    Exporta o sistema de arquivos de um container como um arquivo tar.  
    Exemplo: `docker export nome_do_container > container.tar`

35. **docker import**  
    Cria uma imagem a partir de um container exportado.  
    Exemplo: `docker import container.tar minha_nova_imagem`

### Gerenciamento do Sistema

36. **docker system df**  
    Exibe uso de disco pelos objetos Docker.  
    Exemplo: `docker system df`

37. **docker system prune**  
    Limpa recursos Docker não utilizados (imagens, containers, volumes, redes).  
    Exemplo: `docker system prune`

38. **docker tag**  
    Atribui uma nova tag a uma imagem.  
    Exemplo: `docker tag nome_imagem_antiga nome_imagem_nova`

### Operações de Registro

39. **docker push**  
    Envia uma imagem para um registro Docker.  
    Exemplo: `docker push minha_imagem:tag`

40. **docker login**  
    Faz login em um registro Docker.  
    Exemplo: `docker login`

41. **docker logout**  
    Faz logout de um registro Docker.  
    Exemplo: `docker logout`

### Docker Swarm

42. **docker swarm init**  
    Inicializa um cluster do Docker Swarm mode.  
    Exemplo: `docker swarm init`

43. **docker service create**  
    Cria um novo serviço no Swarm mode.  
    Exemplo: `docker service create --name meu_servico nginx`

44. **docker stack deploy**  
    Implanta uma stack usando um arquivo Compose no Swarm mode.  
    Exemplo: `docker stack deploy -c docker-compose.yml minha_stack`

45. **docker stack rm**  
    Remove uma stack no Swarm mode.  
    Exemplo: `docker stack rm minha_stack`

### Recursos Avançados

46. **docker checkpoint create**  
    Cria um checkpoint para um container.  
    Exemplo: `docker checkpoint create nome_do_container nome_do_checkpoint`

47. **docker checkpoint ls**  
    Lista checkpoints para um container.  
    Exemplo: `docker checkpoint ls nome_do_container`

48. **docker checkpoint rm**  
    Remove um checkpoint.  
    Exemplo: `docker checkpoint rm nome_do_container nome_do_checkpoint`

---

## Comandos Básicos do Kubernetes

O Kubernetes é o regente da sua orquestra de containers. Ele automatiza implantação, escala e gerenciamento de aplicações containerizadas em clusters de servidores.

### Informações do Cluster

1. **kubectl version**  
   Exibe a versão do cliente e servidor Kubernetes.  
   Exemplo: `kubectl version --short`

2. **kubectl cluster-info**  
   Mostra informações sobre o cluster Kubernetes.  
   Exemplo: `kubectl cluster-info`

3. **kubectl get nodes**  
   Lista todos os nós no cluster.  
   Exemplo: `kubectl get nodes`

### Gerenciamento Básico de Recursos

4. **kubectl get pods**  
   Lista todos os pods no namespace padrão.  
   Exemplo: `kubectl get pods`

5. **kubectl get services**  
   Lista todos os serviços no namespace padrão.  
   Exemplo: `kubectl get services`

6. **kubectl get namespaces**  
   Lista todos os namespaces no cluster.  
   Exemplo: `kubectl get namespaces`

7. **kubectl describe pod**  
   Mostra informações detalhadas sobre um pod específico.  
   Exemplo: `kubectl describe pod nome-do-pod`

8. **kubectl logs**  
   Exibe logs para um pod específico.  
   Exemplo: `kubectl logs nome-do-pod`

9. **kubectl create namespace**  
   Cria um novo namespace.  
   Exemplo: `kubectl create namespace meu-namespace`

10. **kubectl delete pod**  
    Deleta um pod específico.  
    Exemplo: `kubectl delete pod nome-do-pod`

### Comandos Intermediários do Kubernetes

11. **kubectl apply**  
    Aplica mudanças definidas em um arquivo YAML.  
    Exemplo: `kubectl apply -f deployment.yaml`

12. **kubectl delete**  
    Deleta recursos definidos em um arquivo YAML.  
    Exemplo: `kubectl delete -f deployment.yaml`

13. **kubectl scale**  
    Escala um deployment para o número desejado de réplicas.  
    Exemplo: `kubectl scale deployment meu-deployment --replicas=3`

14. **kubectl expose**  
    Expõe um pod ou deployment como um serviço.  
    Exemplo: `kubectl expose deployment meu-deployment --type=LoadBalancer --port=80`

15. **kubectl exec**  
    Executa um comando em um pod em execução.  
    Exemplo: `kubectl exec -it nome-do-pod -- /bin/bash`

16. **kubectl port-forward**  
    Encaminha uma porta local para uma porta em um pod.  
    Exemplo: `kubectl port-forward nome-do-pod 8080:80`

17. **kubectl get configmaps**  
    Lista todos os ConfigMaps no namespace.  
    Exemplo: `kubectl get configmaps`

18. **kubectl get secrets**  
    Lista todos os Secrets no namespace.  
    Exemplo: `kubectl get secrets`

19. **kubectl edit**  
    Edita uma definição de recurso diretamente no editor.  
    Exemplo: `kubectl edit deployment meu-deployment`

20. **kubectl rollout status**  
    Exibe o status de um rollout de deployment.  
    Exemplo: `kubectl rollout status deployment/meu-deployment`

### Comandos Avançados do Kubernetes

21. **kubectl rollout undo**  
    Reverte um deployment para uma revisão anterior.  
    Exemplo: `kubectl rollout undo deployment/meu-deployment`

22. **kubectl top nodes**  
    Mostra uso de recursos para nós.  
    Exemplo: `kubectl top nodes`

23. **kubectl top pods**  
    Exibe uso de recursos para pods.  
    Exemplo: `kubectl top pods`

24. **kubectl cordon**  
    Marca um nó como não agendável.  
    Exemplo: `kubectl cordon nome-do-no`

25. **kubectl uncordon**  
    Marca um nó como agendável.  
    Exemplo: `kubectl uncordon nome-do-no`

26. **kubectl drain**  
    Remove com segurança todos os pods de um nó.  
    Exemplo: `kubectl drain nome-do-no --ignore-daemonsets`

27. **kubectl taint**  
    Adiciona uma taint a um nó para controlar posicionamento de pods.  
    Exemplo: `kubectl taint nodes nome-do-no chave=valor:NoSchedule`

28. **kubectl get events**  
    Lista todos os eventos no cluster.  
    Exemplo: `kubectl get events`

29. **kubectl apply -k**  
    Aplica recursos de um diretório kustomization.  
    Exemplo: `kubectl apply -k ./diretorio-kustomization/`

### Gerenciamento de Configuração

30. **kubectl config view**  
    Exibe o arquivo kubeconfig.  
    Exemplo: `kubectl config view`

31. **kubectl config use-context**  
    Alterna o contexto ativo no kubeconfig.  
    Exemplo: `kubectl config use-context meu-cluster`

32. **kubectl debug**  
    Cria uma sessão de depuração para um pod.  
    Exemplo: `kubectl debug nome-do-pod`

33. **kubectl delete namespace**  
    Deleta um namespace e seus recursos.  
    Exemplo: `kubectl delete namespace meu-namespace`

34. **kubectl patch**  
    Atualiza um recurso usando um patch.  
    Exemplo: `kubectl patch deployment meu-deployment -p '{"spec": {"replicas": 2}}'`

### Gerenciamento de Rollout

35. **kubectl rollout history**  
    Mostra o histórico de rollout de um deployment.  
    Exemplo: `kubectl rollout history deployment meu-deployment`

36. **kubectl autoscale**  
    Escala automaticamente um deployment baseado no uso de recursos.  
    Exemplo: `kubectl autoscale deployment meu-deployment --cpu-percent=50 --min=1 --max=10`

### Rotulagem e Anotações

37. **kubectl label**  
    Adiciona ou modifica um rótulo em um recurso.  
    Exemplo: `kubectl label pod nome-do-pod environment=production`

38. **kubectl annotate**  
    Adiciona ou modifica uma anotação em um recurso.  
    Exemplo: `kubectl annotate pod nome-do-pod description="Meu pod da aplicação"`

### Gerenciamento de Armazenamento

39. **kubectl delete pv**  
    Deleta um PersistentVolume (PV).  
    Exemplo: `kubectl delete pv meu-pv`

40. **kubectl get ingress**  
    Lista todos os recursos Ingress no namespace.  
    Exemplo: `kubectl get ingress`

### Criação de Recursos

41. **kubectl create configmap**  
    Cria um ConfigMap a partir de um arquivo ou valores literais.  
    Exemplo: `kubectl create configmap minha-config --from-literal=chave1=valor1`

42. **kubectl create secret**  
    Cria um Secret a partir de um arquivo ou valores literais.  
    Exemplo: `kubectl create secret generic meu-secret --from-literal=password=minhaSenha`

### Recursos da API

43. **kubectl api-resources**  
    Lista todos os recursos da API disponíveis no cluster.  
    Exemplo: `kubectl api-resources`

44. **kubectl api-versions**  
    Lista todas as versões da API suportadas pelo cluster.  
    Exemplo: `kubectl api-versions`

45. **kubectl get crds**  
    Lista todas as CustomResourceDefinitions (CRDs).  
    Exemplo: `kubectl get crds`

---

## Comandos Básicos do Helm

O Helm é a loja de aplicativos para Kubernetes. Ele simplifica a instalação e gerenciamento de aplicações complexas usando "charts" pré-empacotados - pense nele como apt-get para Kubernetes.

### Ajuda e Versão

1. **helm help**  
   Exibe ajuda para a CLI do Helm ou um comando específico.  
   Exemplo: `helm help`

2. **helm version**  
   Mostra a versão do cliente e servidor Helm.  
   Exemplo: `helm version`

### Gerenciamento de Repositórios

3. **helm repo add**  
   Adiciona um novo repositório de charts.  
   Exemplo: `helm repo add stable https://charts.helm.sh/stable`

4. **helm repo update**  
   Atualiza todos os repositórios de charts Helm para a versão mais recente.  
   Exemplo: `helm repo update`

5. **helm repo list**  
   Lista todos os repositórios adicionados ao Helm.  
   Exemplo: `helm repo list`

### Busca de Charts

6. **helm search hub**  
   Busca por charts no Helm Hub.  
   Exemplo: `helm search hub nginx`

7. **helm search repo**  
   Busca por charts nos repositórios.  
   Exemplo: `helm search repo stable/nginx`

8. **helm show chart**  
   Exibe informações sobre um chart, incluindo metadados e dependências.  
   Exemplo: `helm show chart stable/nginx`

### Instalação e Atualização de Charts

9. **helm install**  
   Instala um chart em um cluster Kubernetes.  
   Exemplo: `helm install meu-release stable/nginx`

10. **helm upgrade**  
    Atualiza um release existente com uma nova versão do chart.  
    Exemplo: `helm upgrade meu-release stable/nginx`

11. **helm upgrade --install**  
    Instala um chart se não estiver instalado ou o atualiza se existir.  
    Exemplo: `helm upgrade --install meu-release stable/nginx`

12. **helm uninstall**  
    Desinstala um release.  
    Exemplo: `helm uninstall meu-release`

13. **helm list**  
    Lista todos os releases instalados no cluster Kubernetes.  
    Exemplo: `helm list`

14. **helm status**  
    Exibe o status de um release.  
    Exemplo: `helm status meu-release`

### Trabalhando com Charts Helm

15. **helm create**  
    Cria um novo chart Helm em um diretório especificado.  
    Exemplo: `helm create meu-chart`

16. **helm lint**  
    Verifica um chart para erros comuns.  
    Exemplo: `helm lint ./meu-chart`

17. **helm package**  
    Empacota um chart em um arquivo .tgz.  
    Exemplo: `helm package ./meu-chart`

18. **helm template**  
    Renderiza arquivos YAML do Kubernetes a partir de um chart sem instalá-lo.  
    Exemplo: `helm template meu-release ./meu-chart`

19. **helm dependency update**  
    Atualiza as dependências no arquivo Chart.yaml.  
    Exemplo: `helm dependency update ./meu-chart`

### Comandos Avançados do Helm

20. **helm rollback**  
    Reverte um release para uma versão anterior.  
    Exemplo: `helm rollback meu-release 1`

21. **helm history**  
    Exibe o histórico de um release.  
    Exemplo: `helm history meu-release`

22. **helm get all**  
    Obtém todas as informações (incluindo valores e templates) para um release.  
    Exemplo: `helm get all meu-release`

23. **helm get values**  
    Exibe os valores usados em um release.  
    Exemplo: `helm get values meu-release`

24. **helm test**  
    Executa testes definidos em um chart.  
    Exemplo: `helm test meu-release`

### Repositórios de Charts Helm

25. **helm repo remove**  
    Remove um repositório de charts.  
    Exemplo: `helm repo remove stable`

26. **helm repo update**  
    Atualiza o cache local dos repositórios de charts.  
    Exemplo: `helm repo update`

27. **helm repo index**  
    Cria ou atualiza o arquivo de índice para um repositório de charts.  
    Exemplo: `helm repo index ./charts`

### Valores e Personalização do Helm

28. **helm install --values**  
    Instala um chart com valores personalizados.  
    Exemplo: `helm install meu-release stable/nginx --values valores.yaml`

29. **helm upgrade --values**  
    Atualiza um release com valores personalizados.  
    Exemplo: `helm upgrade meu-release stable/nginx --values valores.yaml`

30. **helm install --set**  
    Instala um chart com um valor personalizado definido diretamente no comando.  
    Exemplo: `helm install meu-release stable/nginx --set replicaCount=3`

31. **helm upgrade --set**  
    Atualiza um release com um valor personalizado definido.  
    Exemplo: `helm upgrade meu-release stable/nginx --set replicaCount=5`

32. **helm uninstall --purge**  
    Remove um release e deleta recursos associados, incluindo o histórico do release.  
    Exemplo: `helm uninstall meu-release --purge`

### Template e Depuração do Helm

33. **helm template --debug**  
    Renderiza manifestos do Kubernetes e inclui saída de debug.  
    Exemplo: `helm template meu-release ./meu-chart --debug`

34. **helm install --dry-run**  
    Simula o processo de instalação para mostrar o que aconteceria sem realmente instalar.  
    Exemplo: `helm install meu-release stable/nginx --dry-run`

35. **helm upgrade --dry-run**  
    Simula um processo de atualização sem realmente aplicá-lo.  
    Exemplo: `helm upgrade meu-release stable/nginx --dry-run`

### Integração Helm e Kubernetes

36. **helm list --namespace**  
    Lista releases em um namespace específico do Kubernetes.  
    Exemplo: `helm list --namespace kube-system`

37. **helm uninstall --namespace**  
    Desinstala um release de um namespace específico.  
    Exemplo: `helm uninstall meu-release --namespace kube-system`

38. **helm install --namespace**  
    Instala um chart em um namespace específico.  
    Exemplo: `helm install meu-release stable/nginx --namespace meunamespace`

39. **helm upgrade --namespace**  
    Atualiza um release em um namespace específico.  
    Exemplo: `helm upgrade meu-release stable/nginx --namespace meunamespace`

### Desenvolvimento de Charts Helm

40. **helm package --sign**  
    Empacota um chart e o assina usando uma chave GPG.  
    Exemplo: `helm package ./meu-chart --sign --key meu-id-de-chave`

41. **helm create --starter**  
    Cria um novo chart Helm baseado em um template inicial.  
    Exemplo: `helm create --starter https://github.com/helm/charts.git`

42. **helm push**  
    Envia um chart para um repositório de charts Helm.  
    Exemplo: `helm push ./meu-chart meu-repo`

### Helm com CLI do Kubernetes

43. **helm list -n**  
    Lista releases em um namespace específico do Kubernetes.  
    Exemplo: `helm list -n kube-system`

44. **helm install --kube-context**  
    Instala um chart em um cluster Kubernetes definido em um contexto específico do kubeconfig.  
    Exemplo: `helm install meu-release stable/nginx --kube-context meu-cluster`

45. **helm upgrade --kube-context**  
    Atualiza um release em um contexto específico do Kubernetes.  
    Exemplo: `helm upgrade meu-release stable/nginx --kube-context meu-cluster`

### Dependências de Charts Helm

46. **helm dependency build**  
    Constrói dependências para um chart Helm.  
    Exemplo: `helm dependency build ./meu-chart`

47. **helm dependency list**  
    Lista todas as dependências para um chart.  
    Exemplo: `helm dependency list ./meu-chart`

### Histórico e Rollbacks do Helm

48. **helm rollback --recreate-pods**  
    Reverte para uma versão anterior e recria pods.  
    Exemplo: `helm rollback meu-release 2 --recreate-pods`

49. **helm history --max**  
    Limita o número de versões mostradas no histórico do release.  
    Exemplo: `helm history meu-release --max 5`

---

## Comandos Básicos do Terraform

O Terraform permite construir infraestrutura em nuvem com código. Em vez de clicar botões nos consoles AWS/GCP/Azure, você define servidores e serviços em arquivos de configuração.

### Ajuda e Inicialização

50. **terraform --help**  
    Exibe ajuda geral para comandos da CLI do Terraform.

51. **terraform init**  
    Inicializa o diretório de trabalho contendo arquivos de configuração do Terraform. Baixa os plugins de provedor necessários.

52. **terraform validate**  
    Valida os arquivos de configuração do Terraform para erros de sintaxe ou problemas.

### Planejamento e Aplicação

53. **terraform plan**  
    Cria um plano de execução, mostrando quais ações o Terraform executará para fazer a infraestrutura corresponder à configuração desejada.

54. **terraform apply**  
    Aplica as mudanças necessárias para alcançar o estado desejado da configuração. Solicitará aprovação antes de fazer mudanças.

55. **terraform show**  
    Exibe o estado do Terraform ou um plano em formato legível.

56. **terraform output**  
    Exibe os valores de saída definidos na configuração do Terraform após uma aplicação.

57. **terraform destroy**  
    Destrói a infraestrutura definida na configuração do Terraform. Solicita confirmação antes de destruir recursos.

### Gerenciamento de Estado

58. **terraform refresh**  
    Atualiza o arquivo de estado com o estado atual real da infraestrutura sem aplicar mudanças.

59. **terraform taint**  
    Marca um recurso para recriação na próxima aplicação. Útil para forçar a recriação de um recurso mesmo que não tenha sido alterado.

60. **terraform untaint**  
    Remove o status "tainted" de um recurso.

61. **terraform state**  
    Gerencia arquivos de estado do Terraform, como mover recursos entre módulos ou manualmente.

62. **terraform import**  
    Importa infraestrutura existente para o gerenciamento do Terraform.

63. **terraform graph**  
    Gera uma representação gráfica dos recursos do Terraform e seus relacionamentos.

64. **terraform providers**  
    Lista os provedores disponíveis para a configuração atual do Terraform.

65. **terraform state list**  
    Lista todos os recursos rastreados no arquivo de estado do Terraform.

66. **terraform backend**  
    Configura o backend para armazenar o estado do Terraform remotamente (por exemplo, no S3, Azure Blob Storage, etc.).

67. **terraform state mv**  
    Move um item no estado de um local para outro.

68. **terraform state rm**  
    Remove um item do arquivo de estado do Terraform.

### Gerenciamento de Workspace

69. **terraform workspace**  
    Gerencia workspaces do Terraform, que permitem criar ambientes separados dentro de uma única configuração.

70. **terraform workspace new**  
    Cria um novo workspace.

71. **terraform module**  
    Gerencia e atualiza módulos do Terraform, que são configurações reutilizáveis.

72. **terraform init -get-plugins=true**  
    Garante que os plugins necessários sejam buscados e disponíveis para módulos.

### Depuração e Logging

73. **TF_LOG**  
    Define o nível de logging para saída de debug do Terraform (por exemplo, TRACE, DEBUG, INFO, WARN, ERROR).

74. **TF_LOG_PATH**  
    Direciona logs do Terraform para um arquivo especificado.

### Integração com Nuvem

75. **terraform login**  
    Faz login no Terraform Cloud ou Terraform Enterprise para gerenciar backends remotos e workspaces.

76. **terraform remote**  
    Gerencia backends remotos e armazenamento de estado remoto para configurações do Terraform.

77. **terraform push**  
    Envia módulos do Terraform para um registro remoto de módulos.

---

## 📝 Licença

Este guia de referência é fornecido sob a Licença MIT. Sinta-se livre para usar, modificar e distribuir.

## 🤝 Contribuindo

Contribuições são bem-vindas! Por favor, sinta-se livre para enviar um Pull Request com comandos adicionais ou melhorias.

## 📬 Contato

Para sugestões ou correções, abra uma issue ou entre em contato com o mantenedor.

---

## 🌍 Versões de Idiomas

- 🇺🇸 [English Version](DevOps-Commands-Cheat-Sheet.md)
- 🇧🇷 [Versão em Português](DevOps-Commands-Cheat-Sheet-PT-BR.md) (Atual)

---

*© 2025 Guia de Referência Rápida - Comandos DevOps - Todos os direitos reservados.*