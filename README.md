# data-engineering-minds-kubernetes
This repository contains the Kubernetes configuration files that I use for my [Youtube](https://www.youtube.com/channel/UCya8wCkH9PSQQgT-50ohYvQ) videos for deploying the below applications:
1. [Node Exporter](https://github.com/vinclv/data-engineering-minds-kubernetes/tree/master/node-exporter)
2. [Prometheus](https://github.com/vinclv/data-engineering-minds-kubernetes/tree/master/prometheus)
3. [Grafana](https://github.com/vinclv/data-engineering-minds-kubernetes/tree/master/grafana)

***Note*** - The configuration files are tested with minikube.

## Applications to be included in the future
1. Kafka ecosystem - Apache Kafka, Kafka Connect, Schema registry, KSQL, and REST Proxy
2. Apache Flink

## Steps to deploy the applications inside Kubernetes
### Prepare the setup
1. Install minikube (this also includes _kubectl_ installation)<br/>
`
brew install minikube
`

2. Set the default context to minikube<br/>
`
kubectl config use-context minikube
`

3. Set the cluster to minikube<br/>
`
kubectl config set-cluster minikube
`

4. Create the namespace - *dem*<br/> 
`kubectl create namespace`

5. Set *dem* as the default namespace<br/>
`kubectl config set-context --current --namespace=vinod`

### Node Exporter
1. Create the daemonset for the node exporter<br/>
`
kubectl apply -f node-exporter/node-exporter-daemonset.yaml
`

2. Create the ClusterIP service for the node exporter application<br/>
`
kubectl apply -f node-exporter/node-exporter-service.yaml
`

3. Check whether the node exporter application is running fine or not via port-forwarding<br/>
`
kubectl port-forward svc/node-exporter-service 9250:9250 -n dem
`

4. Go to the web browser and check the address - *http&#58;//localhost:9250/metrics*

### Prometheus

1. Create cluster role, service account for prometheus, and bind the cluster role to the service account<br/>
`
kubectl apply -f prometheus/prometheus-rbac.yaml
`

2. Create the config map for prometheus<br/>
`
kubectl apply -f prometheus/prometheus-config.yaml
`

3. Create the deployment for prometheus<br/>
`
kubectl apply -f prometheus/prometheus-deployment.yaml
`

4. Before creating the load balancer for prometheus, create a routable network between the host system and the minikube cluster. Type the below command in a sparate terminal window:<br/>
`
minikube tunnel
`

5. Create the load balancer service for the prometheus application<br/>
`
kubectl apply -f prometheus/prometheus-service.yaml
`

6. Go to the web browser and check the address - *http&#58;//localhost:9091* to confirm that prometheus is running fine.

