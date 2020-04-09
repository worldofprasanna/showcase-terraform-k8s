#!/bin/bash

set -e

echo "=========== Persist the terraform output =========="
terraform output kubeconfig > k8s/kubeconfig

echo "=========== Update the kube config manually =========="
echo "It is a manual step. Add cluster, user, context for accessing k8s"

echo "=========== Setting up the worker nodes to join the cluster =========="
terraform output config_map_aws_auth > configmap.yml
kubectl apply -f configmap.yml

echo "=========== Setting up the tiller =========="
kubectl apply -f tiller-user.yaml
helm init --service-account tiller

echo "=========== Setup completed for k8s. Happy Helming !!! =========="
