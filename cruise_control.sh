#!/usr/bin/env bash
set -v
set -o

kubectl --namespace kafka apply -k github.com/baek-jinoo/kubernetes-kafka/cruise-control/?ref=variant_change

kubectl --namespace kafka patch statefulset kafka --patch "$(cat kubernetes-kafka/cruise-control/20kafka-broker-reporter-patch.yml)"
kubectl --namespace kafka apply -k ./kubernetes-kafka/cruise-control/topic-create.yml
