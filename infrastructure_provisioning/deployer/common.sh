#!/bin/bash

function check_env() {
  resource=$1
  env=$2
  echo "Going to provision $resource for $env"
  if [[ $env != "stg" ]]
  then
    echo "Only available environment is staging - stg"
    exit 1
  fi
}

function install() {
  resource=$1
  env=$2

  check_env $resource $env

  cd $resource
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
    echo "$resource provisioned successfully"
    return 0
  else
    echo "some error happened when applying the terraform scripts"
    return 1
  fi
}

function destroy() {
  resource=$1
  env=$2

  check_env $resource $env

  cd $resource
  terraform destroy -var-file="../secrets/$env.tfvars"
}
