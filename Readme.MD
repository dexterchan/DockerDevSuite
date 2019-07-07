## Kafka image

default Listening port 9092

docker build
docker build -f DockerFile.kafka --tag kafka:bk .

docker build  -f ./DockerFile.node10  --tag pigpiggcp/node10.buildtool .

## Create topic

docker exec -it \$containerid kafka-topics.sh --create --bootstrap-server localhost:9092 --replication-factor 1 --partitions 1 --topic test

## list topic

docker exec -it \$containerid kafka-topics.sh --list --bootstrap-server localhost:9092

## test pushing messages

docker exec -it \$containerid kafka-console-producer.sh --broker-list localhost:9092 --topic test

## test consume messages

docker exec -it \$containerid kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic test --from-beginning

Reference
https://rmoff.net/2018/08/02/kafka-listeners-explained/
