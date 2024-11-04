## Description
POC to evaluate SQS message groups and SNS+SQS for fan out architecture

## Run
- Install: `pnpm install`
- Setup: `sh setup.sh`

### Open terminal 1

To consume messages from the sqs fifo queue with messages groups run `pnpm run consume:sqs.fifo`

### Open terminal 2

To consume messages from the 2 queues subscribed to sns topic run `pnpm run consume:sqs_from_sns`

### To produce messages, open a terminal and choose the options:

1. SQS fifo topic with message groups run `produce:sqs`

2. SQS queues subscribed to sns topic run `produce:sns`

_Inspect the bash files for variations_

