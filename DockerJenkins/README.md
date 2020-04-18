#Docker build
docker build --tag jenkins/jenkins:lts-alpine-py .

docker build --tag jenkins/jenkins:lts-alpine-py-gcp -f Dockerfile.alpine.gcp .

docker build --tag jenkins/jenkins:lts-py-gcp -f Dockerfile.debian.gcp .

docker build --tag jenkins/jenkins:centos-py-gcp -f Dockerfile.centos.gcp .

#Start service
docker-compose -f gcp.docker-compose.yml up

#Stop service
docker-compose -f gcp.docker-compose.yml down
