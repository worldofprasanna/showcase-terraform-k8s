#!/bin/bash

set -e

function ecr() {
  env=$1
  echo "Going to provision ecr for $env"
  if [[ $env != "stg" ]]
  then
    echo "Only available environment is staging - stg"
    return 1
  fi

  cd ecr
  terraform plan -out plan.out -var-file="../secrets/$env.tfvars"
  echo "Please verify the plan and type yes"
  read confirmation
  if [[ $confirmation == 'yes' ]]
  then
    echo "Thank you. Applying the changes"
    terraform apply plan.out
  else
    echo "Ok. Operation cancelled"
    return 1
  fi
  if [[ $1 -eq 0 ]]
  then
    echo "ecr provisioned successfully"
    return 0
  else
    echo "some error happened when applying the terraform scripts"
    return 1
  fi
}
