#!/usr/bin/env bash
set -o

kubectl create namespace kafka || true && \
kubectl apply -k ./kubernetes-kafka/variants/gke-regional
