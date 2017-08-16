#!/bin/bash
echo "manually delete kafka and zookeeper files under /tmp (topics messages are here for example)"
echo "Otherwise if topic existed previously you will get saved messages"
sh start_zookeeper.sh
sleep 5s
sh start_kafka.sh
sleep 5s
echo "clearing topics"
sh delete_topic.sh streams-file-input
sh delete_topic.sh streams-wordcount-Counts-changelog
sh delete_topic.sh streams-wordcount-Counts-repartition
sh delete_topic.sh streams-wordcount-output
echo "creating topic"
sh create_topic.sh 1 streams-file-input
sh describe_topic.sh streams-file-input
sh list_topics.sh
cd stream_demo_scripts
echo "reading file file-input.txt to kafka"
sh producer_from_file.sh streams-file-input
echo "running streaming logic"
sh run_word_count.sh
echo "consuming messages"
sh consumer_from_stream.sh streams-wordcount-output
cd ..
sleep 60s
sh delete_topic.sh streams-file-input
sh delete_topic.sh streams-wordcount-Counts-changelog
sh delete_topic.sh streams-wordcount-Counts-repartition
sh delete_topic.sh streams-wordcount-output
sleep 5s
sh stop_kafka.sh
sh stop_zookeeper.sh