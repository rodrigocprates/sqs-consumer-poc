#!/bin/bash

# Define the common parameters
ENDPOINT_URL="http://localhost:4566"
PROFILE="localstack_poc"


# Send messages concurrently

aws sns publish --topic-arn arn:aws:sns:us-east-1:000000000000:sns-topic --message “message1” --endpoint-url "$ENDPOINT_URL" --profile "$PROFILE" &
aws sns publish --topic-arn arn:aws:sns:us-east-1:000000000000:sns-topic --message “message1” --endpoint-url "$ENDPOINT_URL" --profile "$PROFILE" &
aws sns publish --topic-arn arn:aws:sns:us-east-1:000000000000:sns-topic --message “message2” --endpoint-url "$ENDPOINT_URL" --profile "$PROFILE" &
aws sns publish --topic-arn arn:aws:sns:us-east-1:000000000000:sns-topic --message “message3” --endpoint-url "$ENDPOINT_URL" --profile "$PROFILE" &
