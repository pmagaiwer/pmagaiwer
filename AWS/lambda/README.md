1️⃣ Como validar as permissões da Lambda via AWS CLI (passo a passo)
2️⃣ Conteúdo completo de um arquivo lambda-cross-account-validation.md com:


# Lambda AWS

## Permissões Lambda

### Exemplo de política para permitir acesso ao S3

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:PutObject"
      ],
      "Resource": "arn:aws:s3:::nome-do-bucket/*"
    }
  ]
}
```

### Exemplo de política para permitir acesso ao DynamoDB

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "dynamodb:PutItem",
        "dynamodb:GetItem"
      ],
      "Resource": "arn:aws:dynamodb:REGIAO:ID_DA_CONTA:table/NOME_DA_TABELA"
    }
  ]
}
```

## Links úteis

- [Documentação AWS Lambda](https://docs.aws.amazon.com/lambda/latest/dg/welcome.html)
- [Exemplos de políticas IAM](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_examples.html)

## Observações

- Sempre restrinja o acesso apenas aos recursos necessários.
- Utilize variáveis de ambiente para armazenar informações sensíveis.
- Monitore logs e métricas pelo CloudWatch.
aws lambda get-function \
  --function-name minha-lambda \
  --region us-east-1

5. Validar quem está tentando invocar (opcional)

Se for outra conta, confirme a identity policy dela:

aws iam simulate-principal-policy \
  --policy-source-arn arn:aws:iam::222222222222:role/minha-role \
  --action-names lambda:InvokeFunction \
  --resource-arns arn:aws:lambda:us-east-1:111111111111:function:minha-lambda

2️⃣ Arquivo .md — pronto para uso

👉 Crie um arquivo chamado:

lambda-cross-account-validation.md

Conteúdo completo 👇 (copie e cole)
# Validação de Permissões – Lambda Cross-Account

## 📌 Objetivo
Validar e documentar permissões de invocação cross-account em uma função AWS Lambda.

---

## 🧩 Contexto
- Conta da Lambda (Owner): `111111111111`
- Conta Invocadora: `222222222222`
- Região: `us-east-1`
- Nome da Lambda: `minha-lambda`
- Alias/Version: `N/A` (ou especificar)

---

## ✅ Checklist Obrigatório (Pré-Validação)

- [ ] Lambda existe na conta correta
- [ ] Região correta
- [ ] Nome da função correto
- [ ] Uso de Alias/Version validado
- [ ] Resource-based policy configurada na Lambda
- [ ] `statement_id` único
- [ ] Principal correto (Account / Role / Service)
- [ ] `lambda:InvokeFunction` permitido
- [ ] `source-account` e `source-arn` definidos (se serviço AWS)
- [ ] Identity policy do invocador permite `lambda:InvokeFunction`

---

## � Comandos de Validação (AWS CLI)

### 1️⃣ Ver policy da Lambda
```bash
aws lambda get-policy \
  --function-name minha-lambda \
  --region us-east-1


📤 Resultado obtido:

COLE_AQUI_O_OUTPUT_REAL

2️⃣ Ver policy da Lambda (Alias/Version – se aplicável)
aws lambda get-policy \
  --function-name minha-lambda:prod \
  --region us-east-1


📤 Resultado obtido:

COLE_AQUI_SE_EXISTIR

3️⃣ Ver configuração geral da Lambda
aws lambda get-function \
  --function-name minha-lambda \
  --region us-east-1


📤 Resultado obtido:

COLE_AQUI_RESUMO_OU_OUTPUT

4️⃣ Simular permissão do invocador (opcional)
aws iam simulate-principal-policy \
  --policy-source-arn arn:aws:iam::222222222222:role/minha-role \
  --action-names lambda:InvokeFunction \
  --resource-arns arn:aws:lambda:us-east-1:111111111111:function:minha-lambda


📤 Resultado obtido:

COLE_AQUI_O_OUTPUT

🧠 Análise do Resultado
Resource-Based Policy

 Existe Effect: Allow

 Principal correto (AWS, Service)

 Action correta (lambda:InvokeFunction)

 Resource correto (ARN da Lambda)

Conclusão

 Permissão cross-account FUNCIONAL

 Permissão cross-account NÃO FUNCIONAL

📌 Observações:
📎 Referências

AWS Lambda Resource-Based Policy

Terraform aws_lambda_permission

AWS CLI lambda add-permission


---

