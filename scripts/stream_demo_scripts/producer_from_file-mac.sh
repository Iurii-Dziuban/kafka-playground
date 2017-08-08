echo all streams lead to kafka > file-input.txt
echo hello kafka streams >> file-input.txt
echo join kafka summit >> file-input.txt
open -a Terminal.app ../kafka/bin/kafka-console-producer.sh --broker-list localhost:9092 --topic $1 < file-input.txt
