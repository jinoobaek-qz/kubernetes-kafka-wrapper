#!/usr/bin/env bash
set -e

kubectl create namespace kafka || true && \
kubectl apply -k ./kubernetes-kafka/variants/gke-regional
