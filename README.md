# kafka-playground
Kafka related examples

Kafka quick start: https://kafka.apache.org/quickstart

# Examples
## run_test_example
- Start zookeeper
- Stark server (message broker)
- Create topic
- Create producer
- Create consumer
- Manually: write messages to producer. Check messages are received on consumer side
- Stop server
- Stop zookeeper

## run_fault_tolerance_example
- Start zookeeper
- Start server (message broker)
- Start server1 (message broker)
- Start server2 (message broker)
- Create topic with 3 replicas
- Describe topic
- Create producer
- Create consumer
- Manually: write messages to producer, receive on consumer side.
- Manually: stop the leader, mentioned during describe command
- Manually: see new consumer was able to receive previous messages
- Stop server
- Stop server1
- Stop server2
- Stop zookeeper

## run_stream_example
- Start zookeeper
- Stark server (message broker)
- Create topic
- Create producer to read from file stream_demo_scripts/file-input.txt
- Run word count
- Create consumer from stream of word count
- Manually: see consumer received messages
- Stop server
- Stop zookeeper

# Linux examples
  TODO
  
# Windows examples
Examples are 
1) scripts/run_test_example.bat
2) scripts/run_fault_tolerance_example.bat
3) scripts/run_stream_example.bat

*Note:* Do not forget to clean C:/tmp directory from kafka runtime files before running the example!

## Windows kafka basic commands

Note: scripts from the scripts folder can be used for starting zookeeper, kafka servers, creating topics, describing topics, deleting topics, creating producers/consumers

Download kafka from url above, unzip to the path "<project_path>/scripts/kafka"

Further command line commands are executed from the directory "<project_path>/scripts/kafka" folder

- Start zookeeper (one command line)
bin\windows\zookeeper-server-start.bat config\zookeeper.properties

- Start server (one command line)
bin\windows\kafka-server-start.bat config\server.properties

- Create a topic
bin\windows\kafka-topics.bat --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic test
See the message: Created topic "test".
Note: Zookeeper is on the port 2181

- Test topic is created
bin\windows\kafka-topics.bat --list --zookeeper localhost:2181
See: test topic

- Send messages to the topic (one command line)
bin\windows\kafka-console-producer.bat --broker-list localhost:9092 --topic test
(Write couple lines of messages)
Note: Server is on port is on the port 9092

- Consume messages to the topic (one command line)
bin\windows\kafka-console-consumer.bat --bootstrap-server localhost:9092 --topic test --from-beginning
Note: Messages from previous section should be seen
Note: Server is on port is on the port 9092
Note we can create another consumer in the other command line which will receive same messages.

- Adding more brokers (cluster nodes)
 copy config\server.properties config\server-1.properties
 copy config\server.properties config\server-2.properties
 -- update properties for each new kafka server: broker.id, listeners, log.dir
 
- Start more servers:
bin\windows\kafka-server-start.bat config\server-1.properties &
bin\windows\kafka-server-start.bat config\server-2.properties &

- Create and describe replication-topic
bin\windows\kafka-topics.bat --create --zookeeper localhost:2181 --replication-factor 3 --partitions 1 --topic replication-topic
bin\windows\kafka-topics.bat --describe --zookeeper localhost:2181 --topic replication-topic

- Send messages to new topic
bin\windows\kafka-console-producer.bat --broker-list localhost:9092 --topic replicated-topic

- Consume messages from new topic
bin\windows\kafka-console-consumer.bat --bootstrap-server localhost:9092 --topic replicated-topic --from-beginning

stop the leader server and connect with consumer. Messages are received

- Deleting topics
Connect to zookeeper and provide topic name:
bin\windows\zookeeper-shell.bat localhost:2181 rmr /brokers/topics/{your_topic}
example: bin\windows\zookeeper-shell.bat localhost:2181 rmr /brokers/topics/streams-file-input

