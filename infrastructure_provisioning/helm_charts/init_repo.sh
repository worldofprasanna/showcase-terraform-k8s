#!/bin/bash

set -e

echo "Download helm s3 plugin"
helm plugin install https://github.com/hypnoglow/helm-s3.git

echo "Init the s3 bucket to be helm chart repository"
helm S3 init s3://stg-cats-helm-chart/charts
