🚨 4️⃣ CloudWatch Alarms Prontos (Produção)
```bash
aws cloudwatch put-metric-alarm \
  --alarm-name RDS-CPU-High \
  --metric-name CPUUtilization \
  --namespace AWS/RDS \
  --statistic Average \
  --period 300 \
  --threshold 85 \
  --comparison-operator GreaterThanThreshold \
  --evaluation-periods 2 \
  --dimensions Name=DBInstanceIdentifier,Value=MEU_RDS \
  --alarm-actions arn:aws:sns:us-east-1:111111111111:alerts
```

🔥 Pouco espaço em disco
```bash
aws cloudwatch put-metric-alarm \
  --alarm-name RDS-FreeStorage-Low \
  --metric-name FreeStorageSpace \
  --namespace AWS/RDS \
  --statistic Minimum \
  --period 300 \
  --threshold 20000000000 \
  --comparison-operator LessThanThreshold \
  --evaluation-periods 1 \
  --dimensions Name=DBInstanceIdentifier,Value=MEU_RDS \
  --alarm-actions arn:aws:sns:us-east-1:111111111111:alerts
```
(≈ 20 GB)

🔥 Conexões altas
```bash
aws cloudwatch put-metric-alarm \
  --alarm-name RDS-Connections-High \
  --metric-name DatabaseConnections \
  --namespace AWS/RDS \
  --statistic Average \
  --period 300 \
  --threshold 80 \
  --comparison-operator GreaterThanThreshold \
  --evaluation-periods 2 \
  --dimensions Name=DBInstanceIdentifier,Value=MEU_RDS \
  --alarm-actions arn:aws:sns:us-east-1:111111111111:alerts
```

🔥 Replica Lag alto
```bash
aws cloudwatch put-metric-alarm \
  --alarm-name RDS-ReplicaLag-High \
  --metric-name ReplicaLag \
  --namespace AWS/RDS \
  --statistic Maximum \
  --period 300 \
  --threshold 10 \
  --comparison-operator GreaterThanThreshold \
  --evaluation-periods 1 \
  --dimensions Name=DBInstanceIdentifier,Value=MEU_RDS \
  --alarm-actions arn:aws:sns:us-east-1:111111111111:alerts
```

🚀 Como importar dashboards
```bash
aws cloudwatch put-dashboard \
  --dashboard-name RDS-Overview \
  --dashboard-body AWS\rds\cloudwatch\README.md
```

```bash
```

```bash
```