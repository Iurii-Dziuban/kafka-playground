echo "Warning: only marking for delete. Topic will not be deleted"
kafka\bin\windows\kafka-topics.bat --delete --zookeeper localhost:2181 --topic %1
