#!/bin/bash
echo "Warning: only marking for delete. Topic will not be deleted"
exec kafka/bin/kafka-topics.sh --delete --zookeeper localhost:2181 --topic $1
