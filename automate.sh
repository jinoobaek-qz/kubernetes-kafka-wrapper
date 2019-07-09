#!/usr/bin/env bash
set -o
set -x

./runner.sh
./kafka_setup.sh
./prometheus.sh
./cruise_control.sh
#./helm_setup.sh
