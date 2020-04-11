#!/bin/bash

set -e

. ./deployer/common.sh

resource='ecr'
function ecr_install() {
  env=$1
  install $resource $env
}

function ecr_destroy() {
  env=$1
  destroy $resource $env
}