#!/bin/bash

# simple deployment of the ioc-chart helm chart library
#
# run from this directory
# REQUIRED: env CR_PAT must contain a valid GITHUB_TOKEN with needed permissions
#
export HELM_EXPERIMENTAL_OCI=1

IOC_CHART=ghcr.io/epics-containers/helm-ioc-lib
VERSION=$(awk '/appVersion/{print $NF}' Chart.yaml)

echo
echo "Helm repo is ${IOC_CHART}"
echo "WARNING: this is not recommended. Push a Tag and let CI do this instead"
read -p "Deploy IOC Helm Chart Library version ${VERSION} (Y/N)?" -n 1 -r
echo

if [[ ${REPLY} =~ ^[Yy]$ ]]
then
    echo $CR_PAT | helm registry login -u USERNAME --password-stdin ghcr.io/epics-containers

    helm chart save . ${IOC_CHART}:${VERSION}
    helm chart save . ${IOC_CHART}:latest
    helm chart push ${IOC_CHART}:${VERSION}
    helm chart push ${IOC_CHART}:latest
fi



