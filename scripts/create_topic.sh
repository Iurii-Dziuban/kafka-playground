#!/bin/bash
exec kafka/bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor $1 --partitions 1 --topic $2
