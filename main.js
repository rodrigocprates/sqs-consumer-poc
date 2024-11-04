import * as singleQueueWithMultipleConsumers from './sqs-consumers.js';
import * as usingSNSwithSQS from './sns-sqs-consumers.js';

process.env.AWS_PROFILE = 'localstack-poc';

const args = process.argv.slice(2);
const command = args[0];

if (command === 'sqs-with-message-groups') {
    await singleQueueWithMultipleConsumers.consumeUsingMessageGroups("http://sqs.us-east-1.localhost.localstack.cloud:4566/000000000000/my-queue-1.fifo");
} else if (command === 'sns-to-sqs') {
    await usingSNSwithSQS.consumePluggedOnSNS("http://sqs.us-east-1.localhost.localstack.cloud:4566/000000000000/sns-sqs-queue1", "http://sqs.us-east-1.localhost.localstack.cloud:4566/000000000000/sns-sqs-queue2");
} else {
    console.error('Invalid command.');
    process.exit(1);
}