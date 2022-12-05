#!/bin/bash

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

aws eks update-kubeconfig --name helm-deploy-poc --role-arn arn:aws:iam::991619704801:role/OIDC_GH_ADMIN_aws-eks-access

chmod 600 ~/.kube/config

args="$@"
number_of_commands=$(echo $args | cut -d , -f 1 )
loop_count=$((number_of_commands+1))
i=2
while [ $i -le $loop_count ];
do
    command=$(echo $args | cut -d , -f $i )
    # Below code line number 33 to 46 checks whether namespace exists and skip creation if already exists
    namespace_str1=$(echo $command | cut -d ' ' -f 2 ) # extracts create string
    namespace_str2=$(echo $command | cut -d ' '  -f 3 ) # extracts namespace or ns string
    namespace=$(echo $command | cut -d ' '  -f 4 ) # extract namespace name
    namespace_str="${namespace_str1} ${namespace_str2}" # namespace_str will be create namespace or create ns
    search_text='create namespace'
    search_text_alt='create ns'
    if [[ "$namespace_str" == "$search_text" ||  "$namespace_str" = "$search_text_alt"  ]]; then # check whether it is create namespace command
        namespaceStatus=$(kubectl get ns $namespace -o json | jq .status.phase -r) # check whether namespace exists
        if [ $namespaceStatus == "Active" ]
        then
            i=$(( i + 1 ))
            continue      # skip loop if namespace exists
        fi
    fi
    $command  # Executing kubectl commands
    i=$(( i + 1 ))
done