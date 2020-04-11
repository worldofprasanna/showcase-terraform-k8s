#!/bin/bash

set -e

. ./deployer/common.sh

function ecr_install() {
  check_env 'ecr' $1
  env=$1

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

function ecr_destroy() {
  check_env 'ecr' $1
  env=$1

  cd ecr
  terraform destroy -var-file="../secrets/$env.tfvars"
}