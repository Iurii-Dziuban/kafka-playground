#!/bin/bash
echo all streams lead to kafka > file-input.txt
echo hello kafka streams >> file-input.txt
echo join kafka summit >> file-input.txt
exec ../kafka/bin/kafka-console-producer.sh --broker-list localhost:9092 --topic $1 < file-input.txt
