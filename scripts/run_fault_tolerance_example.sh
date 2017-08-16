#!/bin/bash
echo "manually delete kafka and zookeeper files under /tmp (topics messages are here for example)"
echo "Otherwise if topic existed previously you will get saved messages"
echo "Start zookeeper"
sh start_zookeeper.sh
sleep 5s
echo "Start kafka"
sh start_kafka.sh
sleep 5s
echo "Start kafka1"
sh start_kafka1.sh
sleep 5s
echo "Start kafka2"
sh start_kafka2.sh
sh list_topics.sh
sh delete_topic.sh my-replicated-topic
sh create_topic.sh 3 my-replicated-topic
sh describe_topic.sh my-replicated-topic
sleep 5s
echo "Start producer"
sh producer.sh my-replicated-topic
echo "Start consumer"
sh consumer.sh my-replicated-topic
echo "Please enter messages to producer and see messages coming to consumer"
sleep 30s
echo "Please stop the leader. Close terminal with described leader previously"
sleep 30s
echo "See new leader"
sh list_topics.sh
echo "See consumer is able to get producer messages after the leader server went down"
echo "Start consumer"
sh consumer.sh my-replicated-topic
sleep 60s
sh delete_topic.sh my-replicated-topic
sleep 5s
sh stop_kafka.sh
sh stop_kafka1.sh
sh stop_kafka2.sh
sh stop_zookeeper.sh