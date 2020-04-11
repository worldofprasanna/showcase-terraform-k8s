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
