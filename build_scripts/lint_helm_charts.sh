#!/bin/bash

set -e

if [[ $# -lt 1 ]]
then
  echo "Usage: ./build_scripts/lint_helm_charts.sh <api | web>"
  exit 1
fi

service=$1
chart_name="cats-$service"
helm lint "charts/$chart_name"
