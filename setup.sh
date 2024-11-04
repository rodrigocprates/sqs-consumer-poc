#!/bin/bash

# configure aws profile
if aws configure list-profiles | grep -q 'localstack_poc'; then
    echo "Profile localstack_poc already exists. Everything is setup."
else
    echo "Profile localstack_poc does not exist. Setting up now."
    aws configure set aws_access_key_id test --profile localstack_poc
    aws configure set aws_secret_access_key test --profile localstack_poc
    aws configure set region us-east-1 --profile localstack_poc
    echo "Profile localstack_poc created successfully."
fi

# start localstack
docker compose down -v
docker compose up -d
if [ $? -ne 0 ]; then
    echo "Failed to start Docker container."
    exit 1
fi
echo "Docker container for poc started."

# create sqs queue fifo
aws sqs create-queue --attributes FifoQueue=true  --queue-name my-queue-1.fifo --endpoint-url http://localhost:4566 --profile localstack_poc > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "SQS FIFO queue 'my-queue-1.fifo' created successfully."
fi

# create sns topic, sqs queues and subscribe them to the sns topic
aws sns create-topic --name sns-topic --endpoint-url http://localhost:4566  --profile localstack_poc > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "SNS topic 'sns-topic' created successfully."
fi

aws sqs create-queue --queue-name sns-sqs-queue1 --endpoint-url http://localhost:4566 --profile localstack_poc > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "SQS queue 'sns-sqs-queue1' created successfully."
fi

aws sqs create-queue --queue-name sns-sqs-queue2 --endpoint-url http://localhost:4566 --profile localstack_poc > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "SQS queue 'sns-sqs-queue2' created successfully."
fi

aws sns subscribe --topic-arn arn:aws:sns:us-east-1:000000000000:sns-topic --protocol sqs --notification-endpoint arn:aws:sqs:us-east-1:000000000000:sns-sqs-queue1 --attributes RawMessageDelivery=true --endpoint-url http://localhost:4566 --profile localstack_poc > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "SQS queue 'sns-sqs-queue1' subscribed to SNS topic 'sns-topic' successfully."
fi

aws sns subscribe --topic-arn arn:aws:sns:us-east-1:000000000000:sns-topic --protocol sqs --notification-endpoint arn:aws:sqs:us-east-1:000000000000:sns-sqs-queue2 --attributes RawMessageDelivery=true --endpoint-url http://localhost:4566 --profile localstack_poc > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "SQS queue 'sns-sqs-queue2' subscribed to SNS topic 'sns-topic' successfully."
fi
