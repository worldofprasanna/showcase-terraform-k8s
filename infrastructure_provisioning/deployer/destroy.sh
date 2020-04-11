#!/bin/bash

if [[ $# -lt 2 ]]
then
  echo "Usage: ./deployer/destroy.sh <resource | all> <env>"
  exit 1
fi
resource=$1
env=$2

. ./deployer/common.sh

available_resources=('ecr' 'helm_charts' 'eks' 'rds' 'vpc' 'all')
if [[ ! "${available_resources[@]}" =~ ${resource} ]]; then
  echo "Sorry you have given wrong input for resource. Available resource [ ecr | helm_charts | vpc | rds | eks | all ]"
  echo "Usage: ./deployer/destroy.sh <resource | all> <env>"
  exit 1
fi

if [[ $resource == 'all' ]]
then
  for r in "${available_resources[@]}"
  do
    # Don t remove ecr and s3 buckets for now.
    if [[ $r == 'all' ]] || [[ $r == 'ecr' ]] || [[ $r == 'helm_charts' ]]
    then
      continue
    else
      destroy $r $env
    fi
    cd ../
  done
  # echo "" > "secrets/$env.auto.tfvars"
  echo "completed all the resources provisioning"
else
  destroy $resource $env
fi

cd ../