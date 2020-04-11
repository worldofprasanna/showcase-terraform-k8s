#!/bin/bash

set -e

. ./deployer/common.sh

function ecr_install() {
  env=$1
  install 'ecr' $env
}

function ecr_destroy() {
  env=$1
  destroy 'ecr' $env
}