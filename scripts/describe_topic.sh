#!/bin/bash
exec kafka/bin/kafka-topics.sh --describe --zookeeper localhost:2181 --topic $1
