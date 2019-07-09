#!/usr/bin/env bash
set -ex

kubectl create namespace kafka || true && \
kubectl apply -k ./kubernetes-kafka/variants/gke-regional
