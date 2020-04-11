#!/bin/bash

set -e

if [[ $# -lt 2 ]]
then
  echo "Usage: ./deployer/destroy.sh <resource | all> <env>"
  exit 1
fi
resource=$1
env=$2

. ./deployer/ecr.sh

case $resource in
  ecr)
    ecr_destroy $env
  ;;
  helm_charts)
    echo "Going to provision ecr for $env"
  ;;
  vpc)
    echo "Going to provision vpc for $env"
  ;;
  rds)
    echo "Going to provision rds for $env"
  ;;
  eks)
    echo "Going to provision eks for $env"
  ;;
  all)
    echo "Going to provision all for $env"
  ;;
  *)
    echo "Sorry you have given wrong input for resource. Check the usage again"
    echo "Usage: ./deployer/destroy.sh <resource | all> <env>"
    exit 1
  ;;
esac

cd ../