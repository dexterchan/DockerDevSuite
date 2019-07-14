
# Build the image
docker build --tag pigpiggcp/flinkc8 .

export JOB_JAR_TARGET=software/beam_part_i-0.1.jar
docker build --build-arg job_jar="${JOB_JAR_TARGET}"  -t pigpiggcp/flinkc8 .

# Kubectl minikube
https://ci.apache.org/projects/flink/flink-docs-release-1.8/ops/deployment/kubernetes.html

minikube ssh 'sudo ip link set docker0 promisc on'

kubectl create -f jobmanager-deployment.yaml
kubectl create -f jobmanager-service.yaml
kubectl apply -f jobmanager-ingress.yaml

#kubectl create -f taskmanager-deployment.yaml

gcloud beta container --project "peer2peer" clusters create "standard-cluster-1" --zone "us-central1-a" --no-enable-basic-auth --cluster-version "1.12.8-gke.10" --machine-type "n1-standard-4" --image-type "COS" --disk-type "pd-standard" --disk-size "100" --scopes "https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append" --num-nodes "1" --enable-cloud-logging --enable-cloud-monitoring --enable-ip-alias --network "projects/peer2peer/global/networks/default" --subnetwork "projects/peer2peer/regions/us-central1/subnetworks/default" --default-max-pods-per-node "110" --addons HorizontalPodAutoscaling,HttpLoadBalancing --enable-autoupgrade --enable-autorepair