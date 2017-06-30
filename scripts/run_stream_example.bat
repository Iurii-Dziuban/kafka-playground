echo "manually delete kafka and zookeeper files under C:\tmp (topics messages are here for example)"
echo "Otherwise if topic existed previously you will get saved messages"
call start_zookeeper.bat
timeout 5
call start_kafka.bat
timeout 5
echo "clearing topics"
call delete_topic.bat streams-file-input
call delete_topic.bat streams-wordcount-Counts-changelog
call delete_topic.bat streams-wordcount-Counts-repartition
call delete_topic.bat streams-wordcount-output
echo "creating topic"
call create_topic.bat 1 streams-file-input
call describe_topic.bat streams-file-input
call list_topics.bat
cd stream_demo_scripts
echo "reading file file-input.txt to kafka"
call producer_from_file.bat streams-file-input
echo "running streaming logic"
call run_word_count.bat
echo "consuming messages"
call start consumer_from_stream.bat streams-wordcount-output
cd ..
timeout 60
call delete_topic.bat streams-file-input
call delete_topic.bat streams-wordcount-Counts-changelog
call delete_topic.bat streams-wordcount-Counts-repartition
call delete_topic.bat streams-wordcount-output
timeout 5
call stop_kafka.bat
call stop_zookeeper.bat