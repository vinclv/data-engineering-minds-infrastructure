# data-engineering-minds-kubernetes
This repository contains the Kubernetes configuration files that I use for my [Youtube](https://www.youtube.com/channel/UCya8wCkH9PSQQgT-50ohYvQ) videos for deploying the below applications:
1. [Node Exporter](https://github.com/vinclv/data-engineering-minds-kubernetes/tree/master/node-exporter)
2. [Prometheus](https://github.com/vinclv/data-engineering-minds-kubernetes/tree/master/prometheus)
3. [Grafana](https://github.com/vinclv/data-engineering-minds-kubernetes/tree/master/grafana)

**Note:**
1. The configuration files are tested with minikube.
2. Please check my YouTube video for a detailed explanation.

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
1. Create the daemonset for node exporter<br/>
`
kubectl apply -f node-exporter/node-exporter-daemonset.yaml
`

2. Create the ClusterIP service for node exporter application<br/>
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

### Grafana
1. Create the config map for grafana<br/>
`
kubectl apply -f grafana/grafana-config.yaml
`

2. Create the deployment for grafana<br/>
`
kubectl apply -f grafana/grafana-deployment.yaml
`

3. Before creating the load balancer for grafana, create a routable network between the host system and the minikube cluster. Type the below command in a sparate terminal window. If there is already a tunnel running, then skip this step.<br/>
`
minikube tunnel
`

4. Create the load balancer service for the grafana application<br/>
`
kubectl apply -f grafana/grafana-service.yaml
`

5. Go to the web browser and check the address - *http&#58;//localhost:3001* to confirm that grafana is running fine.

6. To create Grafana dashboards for the node exporter, please check my YouTube video.

##Useful links
1. [minikube - Qucik Start](https://minikube.sigs.k8s.io/docs/start/)
2. [Kubernetes Crash Course](https://www.youtube.com/watch?v=s_o8dwzRlu4)
3. [Lens UI for Kubernetes](https://k8slens.dev/)
4. [kubectl cheat sheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)
5. [Docker image for Prometheus](https://hub.docker.com/r/bitnami/prometheus)
6. [Docker image for Grafana](https://hub.docker.com/r/grafana/grafana)
7. [Docker image for Node Exporter](https://hub.docker.com/r/prom/node-exporter)
8. [List of Prometheus configurations](https://prometheus.io/docs/prometheus/latest/configuration/configuration/)
9. [Example data source config file for Grafana](https://grafana.com/docs/grafana/latest/administration/provisioning/#example-data-source-config-file)
10. [Prometheus relabels](https://grafana.com/blog/2022/03/21/how-relabeling-in-prometheus-works/)

