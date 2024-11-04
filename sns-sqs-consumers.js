import { Consumer } from "sqs-consumer";
import { SQSClient } from "@aws-sdk/client-sqs";

export async function consumePluggedOnSNS(queue1Url, queue2Url) {
   
    const c1 = await createConsumer("#Consumer_queue1", queue1Url, buildClient(queue1Url));
    const c2 = await createConsumer("#Consumer_queue2", queue2Url, buildClient(queue2Url));
    
}

function buildClient(queueUrl) {
    return new SQSClient({
        region: "us-east-1",
        credentials: {
          accessKeyId: "test",
          secretAccessKey: "test",
        },
        endpoint: new URL(queueUrl).origin,
      });
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
