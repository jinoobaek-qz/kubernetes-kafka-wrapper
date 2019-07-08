#!/usr/bin/env bash

kubectl create namespace kafka && \
kubectl apply -k github.com/baek-jinoo/kubernetes-kafka/variants/gke-regional/?ref=variant_change
