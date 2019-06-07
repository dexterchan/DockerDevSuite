
https://ci.apache.org/projects/flink/flink-docs-release-1.8/ops/deployment/kubernetes.html

minikube ssh 'sudo ip link set docker0 promisc on'

kubectl create -f jobmanager-deployment.yaml
kubectl create -f taskmanager-deployment.yaml
kubectl create -f jobmanager-service.yaml
kubectl apply -f jobmanager-ingress.yaml