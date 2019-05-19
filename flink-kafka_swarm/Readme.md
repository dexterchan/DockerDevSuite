
eval $(docker-machine env manager)

docker stack deploy -c docker-compose-swarm.yml flink_kafka


kafkacat -b manager:9094,worker:9094 -P -t test


kafkacat -b manager:9094,worker:9094 -C -t test