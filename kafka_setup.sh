#!/usr/bin/env bash

kubectl create namespace kafka || true && \
kubectl apply -k github.com/baek-jinoo/kubernetes-kafka/variants/gke-regional/?ref=variant_change
