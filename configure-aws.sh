# Cria o Bucket
aws s3 mb s3://mybucket --region us-east-1 --endpoint-url http://localhost:4566

# Cria a políticas do IAM
aws iam create-policy --policy-name my-pol --policy-document file://aws/policy-iam.txt --endpoint-url http://localhost:4566

# Cria a função de execução
aws iam create-role --role-name lambda-s3-role --assume-role-policy-document "{"Version": "2012-10-17","Statement": [{ "Effect": "Allow", "Principal": {"Service": "lambda.amazonaws.com"}, "Action": "sts:AssumeRole"}]}"  --endpoint-url http://localhost:4566

# Anexe a política do IAM a uma função do IAM
aws iam attach-role-policy --policy-arn arn:aws:iam::000000000000:policy/my-pol --role-name lambda-s3-role --endpoint-url http://localhost:4566

# Cria a Lambda Function
# criar o package de deploy
./gradlew build
# Cria função
aws lambda create-function --function-name CreateFunction --zip-file fileb://build/libs/spring-aws-lambda-0.0.1-SNAPSHOT.jar --handler com.nayron.springawslambda.application.ServiceHandler::handleRequest --runtime java11 --timeout 10 --memory-size 1024 --package-type Image --role arn:aws:iam::000000000000:role/lambda-s3-role --endpoint-url http://localhost:4566
# Configurar o Amazon S3 para publicar eventos
aws s3api put-bucket-notification-configuration --bucket mybucket --notification-configuration file://aws/notification.json --endpoint-url http://localhost:4566