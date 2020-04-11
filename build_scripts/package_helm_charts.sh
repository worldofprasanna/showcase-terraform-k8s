#!/bin/bash

set -e

if [[ $# -lt 1 ]]
then
  echo "Usage: ./build_scripts/package_helm_charts.sh <api | web>"
  exit 1
fi

service=$1
export REGION="us-east-1"

mkdir -p packaged_charts

echo "Package the helm chart for $service"
chart_name="cats-$service"
helm package "charts/$chart_name" -d packaged_charts/

result=`helm plugin list | grep s3`
if [[ $? -eq 1 ]]
then
  echo "Install the helm s3 plugin"
  apk add git bash
  helm plugin install https://github.com/hypnoglow/helm-s3.git
  mkdir ~/.aws
  cat <<EOT >> ~/.aws/config
  [default]
  region=us-east-1
EOT
  helm s3 init s3://stg-cats-helm-chart/charts
fi

echo "Initialize the helm chart repository"
helm repo add cats-charts s3://stg-cats-helm-chart/charts

echo "Push the charts to s3 bucket"
helm s3 push packaged_charts/$chart_name-*.tgz cats-charts

echo "Task completed"
