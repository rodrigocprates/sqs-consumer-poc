import { Consumer } from "sqs-consumer";
import { SQSClient } from "@aws-sdk/client-sqs";

export async function consumeUsingMessageGroups(queueUrl) {
    
    
    const defaultSqsClient = new SQSClient({
    region: "us-east-1",
    credentials: {
      accessKeyId: "test",
      secretAccessKey: "test",
    },
    endpoint: new URL(queueUrl).origin,
  });

    const c1 = await createConsumer("#Consumer_1", queueUrl, defaultSqsClient);
    const c2 = await createConsumer("#Consumer_2", queueUrl, defaultSqsClient);
    const c3 = await createConsumer("#Consumer_3", queueUrl, defaultSqsClient);

    // c1.stop({ abort: true });
    // c2.stop({ abort: true });
    // c3.stop({ abort: true });

}

async function createConsumer(name, url, client) {

    console.log(`Consuming from ${url} group ${name}....`);

    const c = Consumer.create({
        queueUrl: url,
        handleMessage: async (message) => {
            console.log(name, message);
        }, 
        sqs: client
    }).on("error", (err) => {
        console.error(err.message);
    }).on("processing_error", (err) => {
        console.error(err.message);
    })
    
    c.start();

    return c;
}
