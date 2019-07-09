#!/usr/bin/env bash
set -o
set -x

PROJECT_ID=${PROJECT_ID:-quizlet-data-services}
ZONE_ID=${ZONE_ID:-us-central1-c}
REGION_ID=${REGION_ID:-us-central1}
CLUSTER_NAME=${CLUSTER_NAME:-cluster-name-1}
CLUSTER_VERSION=${CLUSTER_VERSION:-1.12.8-gke.10}
NETWORK_NAME=${NETWORK_NAME:-jin-experiment}
NODE_LOCATIONS=${NODE_LOCATIONS:-us-central1-a,us-central1-c,us-central1-f}

gcloud config set project "$PROJECT_ID"
gcloud config set compute/zone "$ZONE_ID"

gcloud beta container --project "quizlet-data-services" \
  clusters create ${CLUSTER_NAME} \
  --region ${REGION_ID} \
  --no-enable-basic-auth \
  --cluster-version "1.12.8-gke.10" \
  --machine-type "n1-standard-2" \
  --image-type "COS" \
  --disk-type "pd-standard" \
  --disk-size "30" \
  --node-locations ${NODE_LOCATIONS} \
  --network "projects/quizlet-data-services/global/networks/jin-experiment" \
  --subnetwork "projects/quizlet-data-services/regions/us-central1/subnetworks/jin-experiment" \
  --metadata disable-legacy-endpoints=true \
  --scopes "https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append" \
  --num-nodes "1" \
  --enable-cloud-logging \
  --enable-cloud-monitoring \
  --no-enable-ip-alias \
  --enable-autoscaling \
  --min-nodes "1" \
  --max-nodes "3" \
  --addons HorizontalPodAutoscaling,HttpLoadBalancing \
  --enable-autoupgrade \
  --enable-autorepair \
  --maintenance-window "10:00" \
  && gcloud beta container --project ${PROJECT_ID} \
  node-pools create "pool-1" \
  --cluster ${CLUSTER_NAME} \
  --region "us-central1" \
  --node-version "1.12.8-gke.10" \
  --machine-type "n1-standard-2" \
  --image-type "COS" \
  --disk-type "pd-ssd" \
  --disk-size "30" \
  --enable-autoscaling \
  --min-nodes "1" \
  --max-nodes "3" \
  --metadata disable-legacy-endpoints=true \
  --scopes "https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append" \
  --num-nodes "1" \
  --enable-autoupgrade \
  --enable-autorepair


gcloud container clusters get-credentials ${CLUSTER_NAME} --project ${PROJECT_ID} --region ${REGION_ID}

