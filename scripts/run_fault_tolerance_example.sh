#!/bin/bash
echo "manually delete kafka and zookeeper files under /tmp (topics messages are here for example)"
echo "Otherwise if topic existed previously you will get saved messages"
echo "Start zookeeper"
exec start_zookeeper.sh
sleep 5s
echo "Start kafka"
exec start_kafka.sh
sleep 5s
echo "Start kafka1"
exec start_kafka1.sh
sleep 5s
echo "Start kafka2"
exec start_kafka2.sh
exec list_topics.sh
exec delete_topic.sh my-replicated-topic
exec create_topic.sh 3 my-replicated-topic
exec describe_topic.sh my-replicated-topic
sleep 5s
echo "Start producer"
exec producer.sh my-replicated-topic
echo "Start consumer"
exec consumer.sh my-replicated-topic
echo "Please enter messages to producer and see messages coming to consumer"
sleep 30s
echo "Please stop the leader. Close terminal with described leader previously"
sleep 30s
echo "See new leader"
exec list_topics.sh
echo "See consumer is able to get producer messages after the leader server went down"
echo "Start consumer"
exec consumer.sh my-replicated-topic
sleep 60s
exec delete_topic.sh my-replicated-topic
sleep 5s
exec stop_kafka.sh
exec stop_kafka1.sh
exec stop_kafka2.sh
exec stop_zookeeper.sh