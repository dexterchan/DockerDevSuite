bin/zookeeper-server-start.sh config/zookeeper.properties & 
sleep 10
bin/kafka-server-start.sh config/server.properties 
#sleep 5
#bin/kafka-topics.sh --create --bootstrap-server localhost:9092 --replication-factor 1 --partitions 1 --topic test