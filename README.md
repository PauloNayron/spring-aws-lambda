# spring-aws-lambda
Projeto de Estudo de Spring Cloud Function com AWS Lambda
## Comandos Docker
### Iniciar containers Docker
```shell
docker-compose up
```

### Criar um Bucket
```shell
aws s3 mb s3://mybucket --region us-east-1 --endpoint-url http://localhost:4566
```

### Criar a política do IAM
```shell
aws iam create-policy --policy-name my-pol --policy-document file://aws/policy-iam.txt --endpoint-url http://localhost:4566
```

### Criar a função de execução
````shell
aws iam create-role --role-name lambda-s3-role --assume-role-policy-document "{"Version": "2012-10-17","Statement": [{ "Effect": "Allow", "Principal": {"Service": "lambda.amazonaws.com"}, "Action": "sts:AssumeRole"}]}"  --endpoint-url http://localhost:4566
````

### Anexe a política do IAM a uma função do IAM
```shell
aws iam attach-role-policy --policy-arn arn:aws:iam::000000000000:policy/my-pol --role-name lambda-s3-role --endpoint-url http://localhost:4566
```

### Criar a Lambda Function
criar o build, para criar o package de deploy
```shell
./gradlew build
```

````shell
aws lambda create-function --function-name CreateFunction --zip-file fileb://build/libs/aws-lamda-s3-1.0-SNAPSHOT.jar --handler example.Handler::handleRequest --runtime java11 --timeout 10 --memory-size 1024 --role arn:aws:iam::000000000000:role/lambda-s3-role --endpoint-url http://localhost:4566
````

### Configurar o Amazon S3 para publicar eventos
```shell
aws s3api put-bucket-notification-configuration --bucket mybucket --notification-configuration file://aws/notification.json --endpoint-url http://localhost:4566
```

### Teste usando o gatilho S3
````shell
aws s3 cp myfile.txt s3://mybucket --endpoint-url http://localhost:4566
````