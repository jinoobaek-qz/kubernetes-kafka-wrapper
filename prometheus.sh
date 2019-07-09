#!/usr/bin/env bash
set -ex

kubectl --namespace kafka apply -f kubernetes-kafka/prometheus/10-metrics-config.yml
kubectl --namespace kafka patch statefulset kafka --patch "$(cat kubernetes-kafka/prometheus/50-kafka-jmx-exporter-patch.yml )"

