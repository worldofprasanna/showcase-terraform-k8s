#!/bin/bash

set -e

. ./deployer/common.sh

resource='helm_charts'

function helm_charts_install() {
  env=$1
  install $resource $env
}

function helm_charts_destroy() {
  env=$1
  destroy $resource $env
}