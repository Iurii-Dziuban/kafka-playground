#!/bin/bash
echo "manually delete kafka and zookeeper files under /tmp (topics messages are here for example)"
echo "Otherwise if topic existed previously you will get saved messages"
echo "Run zookeeper"
exec start_zookeeper.sh
sleep 5s
echo "Run kafka"
exec start_kafka.sh
sleep 5s
exec list_topics.sh
echo "deleting topic if it was existing"
exec delete_topic.sh test
exec create_topic.sh 1 test
exec describe_topic.sh test
echo "Run producer"
exec producer.sh test
echo "Run consumer"
exec consumer.sh test
sleep 60s
exec delete_topic.sh test
sleep 5s
exec stop_kafka.sh
exec stop_zookeeper.sh