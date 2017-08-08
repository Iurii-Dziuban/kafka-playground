#!/bin/bash
exec kafka/bin/zookeeper-shell.sh localhost:2181 rmr /brokers/topics/$1
