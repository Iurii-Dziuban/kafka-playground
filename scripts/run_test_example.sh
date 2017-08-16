#!/bin/bash
echo "manually delete kafka and zookeeper files under /tmp (topics messages are here for example)"
echo "Otherwise if topic existed previously you will get saved messages"
echo "Run zookeeper"
sh start_zookeeper.sh
sleep 5s
echo "Run kafka"
sh start_kafka.sh
sleep 5s
sh list_topics.sh
echo "deleting topic if it was existing"
sh delete_topic.sh test
sh create_topic.sh 1 test
sh describe_topic.sh test
echo "Run producer"
sh producer.sh test
echo "Run consumer"
sh consumer.sh test
sleep 60s
sh delete_topic.sh test
sleep 5s
sh stop_kafka.sh
sh stop_zookeeper.sh