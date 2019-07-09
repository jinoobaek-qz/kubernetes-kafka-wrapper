#!/usr/bin/env bash
set -o

./runner.sh
./kafka_setup.sh
./prometheus.sh
./cruise_control.sh
./helm_setup.sh
./connect_and_schema.sh
