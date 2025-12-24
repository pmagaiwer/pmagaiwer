## Como validar as permissões da Lambda via AWS CLI (passo a passo)



1️⃣ Validando permissões de uma Lambda via AWS CLI
1. Ver a policy da Lambda (principal)

Esse é o comando mais importante.

aws lambda get-policy \
  --function-name minha-lambda \
  --region us-east-1


🔎 Isso retorna um JSON com a resource-based policy da Lambda.

2. Exemplo de saída esperada (resumo)
{
  "Policy": "{ 
    \"Statement\": [
      {
        \"Sid\": \"AllowCrossAccountInvoke\",
        \"Effect\": \"Allow\",
        \"Principal\": { \"AWS\": \"222222222222\" },
        \"Action\": \"lambda:InvokeFunction\",
        \"Resource\": \"arn:aws:lambda:us-east-1:111111111111:function:minha-lambda\"
      }
    ]
  }"
}

3. Validar versão / alias (se existir)

Se a Lambda usa alias ou version, valide explicitamente:

aws lambda get-policy \
  --function-name minha-lambda:prod \
  --region us-east-1


⚠️ Permissão não herda automaticamente entre $LATEST, version e alias.

4. Ver configuração geral da Lambda

Ajuda a evitar erro de região, nome ou runtime:


# AWS Lambda

## Comandos Úteis

### Listar funções Lambda
```bash
aws lambda list-functions --region <região>
```

### Invocar função Lambda
```bash
aws lambda invoke \
  --function-name <nome-da-funcao> \
  --payload '{"key": "value"}' \
  output.json \
  --region <região>
```

### Atualizar código da função Lambda
```bash
aws lambda update-function-code \
  --function-name <nome-da-funcao> \
  --zip-file fileb://arquivo.zip \
  --region <região>
```

### Excluir função Lambda
```bash
aws lambda delete-function --function-name <nome-da-funcao> --region <região>
```

### Listar logs da função Lambda (CloudWatch)
```bash
aws logs filter-log-events \
  --log-group-name /aws/lambda/<nome-da-funcao> \
  --region <região>
```

### Adicionar permissão à função Lambda
```bash
aws lambda add-permission \
  --function-name <nome-da-funcao> \
  --action lambda:InvokeFunction \
  --statement-id <id> \
  --principal <serviço> \
  --region <região>
```

### Remover permissão da função Lambda
```bash
aws lambda remove-permission \
  --function-name <nome-da-funcao> \
  --statement-id <id> \
  --region <região>
```

### Listar permissões da função Lambda
```bash
aws lambda get-policy --function-name <nome-da-funcao> --region <região>
```

### Atualizar variáveis de ambiente
```bash
aws lambda update-function-configuration \
  --function-name <nome-da-funcao> \
  --environment "Variables={VAR1=valor1,VAR2=valor2}" \
  --region <região>
```
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

## 3️⃣ Próximo nível (opcional)
Se quiser, posso:
- interpretar **seu output real**
- revisar se está **seguro ou permissivo demais**
- gerar a **policy Terraform final baseada no estado atual**
- criar uma **versão auditoria-ready (SOC2 / ISO)**

É só colar aqui o output do `get-policy`.