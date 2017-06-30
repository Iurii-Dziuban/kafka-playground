echo "manually delete kafka and zookeeper files under C:\tmp (topics messages are here for example)"
echo "Otherwise if topic existed previously you will get saved messages"
call start_zookeeper.bat
timeout 5
call start_kafka.bat
timeout 5
call list_topics.bat
echo "deleting topic if it was existing"
call delete_topic.bat test
call create_topic.bat 1 test
call describe_topic.bat test
call start producer.bat test
call start consumer.bat test
timeout 60
call delete_topic.bat test
timeout 5
call stop_kafka.bat
call stop_zookeeper.bat