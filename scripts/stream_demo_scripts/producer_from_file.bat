echo all streams lead to kafka > file-input.txt
echo hello kafka streams >> file-input.txt
echo|set /p=join kafka summit >> file-input.txt
..\kafka\bin\windows\kafka-console-producer.bat --broker-list localhost:9092 --topic %1 < file-input.txt
