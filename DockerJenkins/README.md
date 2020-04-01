

#Docker build
docker build  --tag jenkins/jenkins:lts-alpine-py .

docker build  --tag jenkins/jenkins:lts-alpine-py-gcp -f Dockerfile.gcp .

#Start service
docker-compose -f gcp.docker-compose.yml up

#Stop service
docker-compose -f gcp.docker-compose.yml down