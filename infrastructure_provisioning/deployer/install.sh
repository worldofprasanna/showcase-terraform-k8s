#!/bin/bash

if [[ $# -lt 2 ]]
then
  echo "Usage: ./deployer/install.sh <resource | all> <env>"
  exit 1
fi
resource=$1
env=$2

. ./deployer/common.sh

available_resources=('ecr' 'helm_charts' 'vpc' 'rds' 'eks' 'all')
if [[ ! "${available_resources[@]}" =~ ${resource} ]]; then
  echo "Sorry you have given wrong input for resource. Available resource [ ecr | helm_charts | vpc | rds | eks | all ]"
  echo "Usage: ./deployer/install.sh <resource | all> <env>"
  exit 1
fi

if [[ $resource == 'all' ]]
then
  for r in "${available_resources[@]}"
  do
    if [[ $r == 'all' ]]
    then
      continue
    else
      install $r $env
    fi
  done
  echo "completed all the resources provisioning"
else
  install $resource $env
fi

cd ../