# AWS SQS & SNS – AWS CLI Cheatsheet

## 📌 Objetivo
Referência rápida de comandos básicos para gerenciar **Amazon SQS** e **Amazon SNS** usando AWS CLI.

---

## 🔧 Pré-requisitos
- AWS CLI configurado (`aws configure`)
- Permissões IAM adequadas
- Região correta definida (`--region` ou variável de ambiente)

---

# 📬 Amazon SQS

## 📂 Listagem

### Listar filas
```bash
aws sqs list-queues


---

# 🔗 Integração Amazon SNS + Amazon SQS

## 🧠 Visão Geral

A integração entre **SNS** e **SQS** é usada para implementar o padrão **fan-out**, onde:

- **SNS** atua como **publisher / broker**
- **SQS** atua como **subscriber / buffer de mensagens**

Um único evento publicado em um tópico SNS pode ser entregue a **múltiplas filas SQS**, permitindo:
- Processamento assíncrono
- Escalabilidade
- Desacoplamento entre produtores e consumidores

---

## 🔄 Fluxo de Funcionamento

1. Um produtor publica uma mensagem no **SNS Topic**
2. O SNS entrega a mensagem para **todas as subscriptions**
3. Cada **fila SQS** recebe sua própria cópia da mensagem
4. Consumidores processam mensagens da fila no seu próprio ritmo

Producer
|
v
SNS Topic
|
+--> SQS Queue A --> Consumer A
|
+--> SQS Queue B --> Consumer B


---

## ✅ Por que usar SNS + SQS juntos?

### Vantagens
- 📦 **Persistência**: mensagens ficam armazenadas na SQS
- 🔁 **Retry automático**: baseado em visibility timeout
- ☠️ **DLQ**: mensagens problemáticas podem ser isoladas
- 📈 **Escalabilidade independente**
- 🧩 **Baixo acoplamento**

### Quando NÃO usar apenas SNS
SNS puro:
- Não garante consumo
- Não tem retry por consumidor
- Não tem DLQ nativo por subscriber

---

## 🧪 Exemplo prático de uso

### Caso comum
- Evento de pedido criado
- Vários sistemas precisam reagir:
  - Faturamento
  - Notificação
  - Analytics

👉 SNS publica  
👉 Cada sistema tem sua própria fila SQS

---

## 🔐 Permissões Necessárias (Ponto Crítico)

### Policy da fila SQS permitindo SNS

A fila SQS **precisa permitir explicitamente** que o SNS envie mensagens.

Exemplo de policy (`policy.json`):

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "sns.amazonaws.com"
      },
      "Action": "sqs:SendMessage",
      "Resource": "arn:aws:sqs:us-east-1:111111111111:minha-fila",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "arn:aws:sns:us-east-1:111111111111:meu-topico"
        }
      }
    }
  ]
}
```

# Aplicar a policy:

```bash
aws sqs set-queue-attributes \
  --queue-url https://sqs.us-east-1.amazonaws.com/111111111111/minha-fila \
  --attributes file://policy.json
```

# 📦 SNS + SQS FIFO (Importante)

## Regras:

- SNS FIFO somente entrega para SQS FIFO
- Ambos devem terminar com .fifo
- Message Group ID é obrigatório

Exemplo de publish:
```bash
aws sns publish \
  --topic-arn arn:aws:sns:us-east-1:111111111111:meu-topico.fifo \
  --message "Hello FIFO" \
  --message-group-id grupo-1
```

# 🛠️ Boas Práticas

- Use SNS para fan-out
- Use SQS para processamento confiável
- Sempre configure DLQ

# Monitore:
- ApproximateAgeOfOldestMessage
- NumberOfMessagesVisible

# Evite processamento pesado direto no SNS

Prefira SQS entre SNS e Lambda para workloads críticos


⚠️ Erros Comuns

- ❌ Esquecer policy da SQS-
- ❌ Usar SNS FIFO com SQS Standard
- ❌ Não configurar DLQ
- ❌ Visibility Timeout menor que o tempo de processamento

# 📚 Referências Oficiais (AWS)

SNS + SQS Fan-out
https://docs.aws.amazon.com/sns/latest/dg/sns-sqs-as-subscriber.html

Amazon SNS Developer Guide
https://docs.aws.amazon.com/sns/latest/dg/welcome.html

Amazon SQS Developer Guide
https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/welcome.html

SNS FIFO Topics
https://docs.aws.amazon.com/sns/latest/dg/fifo-topics.html

SQS Access Policy Examples
https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-basic-examples-of-sqs-policies.html

# 📚 Referências de Terceiros

AWS Architecture Blog – Fanout pattern
https://aws.amazon.com/blogs/architecture/fanout-using-amazon-sns-and-amazon-sqs/

Serverless Land – SNS + SQS
https://serverlessland.com/patterns/sns-sqs

The Twelve-Factor App (Background Jobs)
https://12factor.net/background-jobs

# 🧠 Conclusão

##  SNS + SQS juntos formam um dos padrões mais usados na AWS para:

- Eventos
- Processamento assíncrono
- Arquiteturas resilientes e desacopladas

- 👉 SNS distribui
- 👉 SQS garante entrega
- 👉 Consumidores processam com segurança