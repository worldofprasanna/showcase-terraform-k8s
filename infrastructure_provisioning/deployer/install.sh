#!/bin/bash

if [[ $# -lt 2 ]]
then
  echo "Usage: ./deployer/install.sh <resource | all> <env>"
  exit 1
fi
resource=$1
env=$2

. ./deployer/ecr.sh
. ./deployer/helm_charts.sh

case $resource in
  ecr)
    ecr_install $env
  ;;
  helm_charts)
    helm_charts_install $env
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
    echo "Sorry you have given wrong input for resource. Available resource [ ecr | helm_charts | vpc | rds | eks | all ]"
    echo "Usage: ./deployer/install.sh <resource | all> <env>"
    exit 1
  ;;
esac

cd ../