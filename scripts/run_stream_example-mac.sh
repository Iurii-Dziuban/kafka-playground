#!/bin/bash
echo "manually delete kafka and zookeeper files under /tmp (topics messages are here for example)"
echo "Otherwise if topic existed previously you will get saved messages"
exec start_zookeeper-mac.sh
sleep 5s
exec start_kafka-mac.sh
sleep 5s
echo "clearing topics"
exec delete_topic.sh streams-file-input
exec delete_topic.sh streams-wordcount-Counts-changelog
exec delete_topic.sh streams-wordcount-Counts-repartition
exec delete_topic.sh streams-wordcount-output
echo "creating topic"
exec create_topic.sh 1 streams-file-input
exec describe_topic.sh streams-file-input
exec list_topics.sh
cd stream_demo_scripts
echo "reading file file-input.txt to kafka"
exec producer_from_file-mac.sh streams-file-input
echo "running streaming logic"
exec run_word_count.sh
echo "consuming messages"
exec consumer_from_stream-mac.sh streams-wordcount-output
cd ..
sleep 60s
exec delete_topic.sh streams-file-input
exec delete_topic.sh streams-wordcount-Counts-changelog
exec delete_topic.sh streams-wordcount-Counts-repartition
exec delete_topic.sh streams-wordcount-output
sleep 5s
exec stop_kafka.sh
exec stop_zookeeper.sh