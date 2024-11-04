#!/bin/bash

# Define the common parameters
QUEUE_URL="http://sqs.us-east-1.localhost.localstack.cloud:4566/000000000000/my-queue-1.fifo"
ENDPOINT_URL="http://localhost:4566"
PROFILE="localstack_poc"

# Define the messages
MESSAGE_1='{"group":"group1"}'
MESSAGE_2='{"group":"group2"}'
MESSAGE_3='{"group":"group3"}'

# Define the group and deduplication IDs
GROUP_ID_1="group1"
GROUP_ID_2="group2"
GROUP_ID_3="group3"

# Send messages concurrently
aws sqs send-message --queue-url "$QUEUE_URL" --endpoint-url "$ENDPOINT_URL" --message-body "$MESSAGE_1" --message-group-id "$GROUP_ID_1" --message-deduplication-id "$(uuidgen)" --profile "$PROFILE" &
# aws sqs send-message --queue-url "$QUEUE_URL" --endpoint-url "$ENDPOINT_URL" --message-body "$MESSAGE_1" --message-group-id "$GROUP_ID_1" --message-deduplication-id "$(uuidgen)" --profile "$PROFILE" &
aws sqs send-message --queue-url "$QUEUE_URL" --endpoint-url "$ENDPOINT_URL" --message-body "$MESSAGE_2" --message-group-id "$GROUP_ID_2" --message-deduplication-id "$(uuidgen)" --profile "$PROFILE" &
# aws sqs send-message --queue-url "$QUEUE_URL" --endpoint-url "$ENDPOINT_URL" --message-body "$MESSAGE_2" --message-group-id "$GROUP_ID_2" --message-deduplication-id "$(uuidgen)" --profile "$PROFILE" &
# aws sqs send-message --queue-url "$QUEUE_URL" --endpoint-url "$ENDPOINT_URL" --message-body "$MESSAGE_3" --message-group-id "$GROUP_ID_3" --message-deduplication-id "$(uuidgen)" --profile "$PROFILE" &
# aws sqs send-message --queue-url "$QUEUE_URL" --endpoint-url "$ENDPOINT_URL" --message-body "$MESSAGE_1" --message-group-id "$GROUP_ID_1" --message-deduplication-id "$(uuidgen)" --profile "$PROFILE" &
# aws sqs send-message --queue-url "$QUEUE_URL" --endpoint-url "$ENDPOINT_URL" --message-body "$MESSAGE_3" --message-group-id "$GROUP_ID_3" --message-deduplication-id "$(uuidgen)" --profile "$PROFILE" &
