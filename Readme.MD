
## Kafka image
default Listening port 9092

docker build
docker build -f DockerFile.kafka --tag kafka:bk .

## Create topic
docker exec -it < containerid > kafka-topics.sh --create --bootstrap-server localhost:9092 --replication-factor 1 --partitions 1 --topic test

## list topic
docker exec -it < containerid >  kafka-topics.sh --list --bootstrap-server localhost:9092

## test pushing a msg
docker exec -it < containerid >  kafka-console-producer.sh --broker-list localhost:9092 --topic test