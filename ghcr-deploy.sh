#!/bin/bash

# simple deployment of the ioc-chart helm chart library
#
# run from this directory
# REQUIRED: env CR_PAT must contain a valid GITHUB_TOKEN with needed permissions
#
REGISTRY=oci://ghcr.io/epics-containers
VERSION=$(awk '/appVersion:/{print $NF}' Chart.yaml)
NAME=$(awk '/name:/{print $NF}' Chart.yaml)

this_dir=$(realpath $(dirname $0))

echo
echo "Helm repo is ${REGISTRY}/${NAME}"
echo "WARNING: this is not recommended. Push a Tag and let CI do this instead"
read -p "Deploy IOC Helm Chart Library version ${VERSION} (Y/N)?" -n 1 -r
echo

if [[ ${REPLY} =~ ^[Yy]$ ]]
then
    echo $CR_PAT | helm registry login -u USERNAME --password-stdin ghcr.io/epics-containers

    helm dependency update
    helm package ${this_dir}
    package=${NAME}-${VERSION}.tgz
    helm push "$package" $REGISTRY
fi



