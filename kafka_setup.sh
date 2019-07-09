#!/usr/bin/env bash

kubectl create namespace kafka || true && \
kubectl apply -k ./kubernetes-kafka/variants/gke-regional
