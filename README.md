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


