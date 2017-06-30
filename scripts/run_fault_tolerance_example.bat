echo "manually delete kafka and zookeeper files under C:\tmp (topics messages are here for example)"
echo "Otherwise if topic existed previously you will get saved messages"
call start_zookeeper.bat
timeout 5
call start_kafka.bat
timeout 5
call start_kafka1.bat
timeout 5
call start_kafka2.bat
call list_topics.bat
call delete_topic.bat my-replicated-topic
call create_topic.bat 3 my-replicated-topic
call describe_topic.bat my-replicated-topic
timeout 5
call start producer.bat my-replicated-topic
call start consumer.bat my-replicated-topic
echo "Please enter messages to producer and see messages coming to consumer"
timeout 30
echo "Please stop the leader. Close terminal with described leader previously"
timeout 30
echo "See new leader"
call list_topics.bat
echo "See consumer is able to get producer messages after the leader server went down"
call consumer.bat my-replicated-topic
timeout 60
call delete_topic.bat my-replicated-topic
timeout 5
call stop_kafka.bat
call stop_kafka1.bat
call stop_kafka2.bat
call stop_zookeeper.bat