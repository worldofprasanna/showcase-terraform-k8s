#!/bin/bash

set -e

if [[ $# -lt 1 ]]
then
  echo "Usage: ./build_scripts/package_helm_charts.sh <api | web>"
  exit 1
fi

service=$1

echo "Package the helm chart for $service"
echo "Install the helm s3 plugin"
echo "Initialize the helm chart repository"
echo "Push the charts to s3 bucket"
echo "Task completed"