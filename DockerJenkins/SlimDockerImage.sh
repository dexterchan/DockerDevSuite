#!/bin/bash
IMAGE=$1
echo "Please keep the docker image running first"
docker run --rm -it -d $IMAGE bash

export containerid=$(docker ps | grep $IMAGE | awk '{print $1}')

docker export --output temp.docker.tar ${containerid}

cat temp.docker.tar | docker import - tmpslim

docker build -f Dockerfile.slim.post \
--tag ${IMAGE} .

docker stop ${containerid}
docker rmi --force tmpslim
rm -Rf temp.docker.tar