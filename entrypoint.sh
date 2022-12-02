#!/bin/sh

set -ex

if [ -n "${AWS_ACCESS_KEY_ID}" ]; then
  export AWS_ACCESS_KEY_ID="${AWS_ACCESS_KEY_ID}"
fi

if [ -n "${AWS_SECRET_ACCESS_KEY}" ]; then
  export AWS_SECRET_ACCESS_KEY="${AWS_SECRET_ACCESS_KEY}"
fi

if [ -n "${AWS_REGION}" ]; then
  export AWS_DEFAULT_REGION="${AWS_REGION}"
fi

if [ -n "${CLUSTER_NAME}" ]; then
  export CLUSTER_NAME="${CLUSTER_NAME}"
fi

aws eks update-kubeconfig --name helm-deploy-poc

chmod 600 ~/.kube/config

arg1=$(awk -F; '{print $1}' <<< '$@')
arg2=$(awk -F; '{print $2}' <<< '$@')
kubectl ${arg1}
kubectl ${arg2}
