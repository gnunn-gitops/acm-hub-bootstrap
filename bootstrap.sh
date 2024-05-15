#!/bin/bash

LANG=C
SLEEP_SECONDS=30

echo ""
echo "Installing RHACM Operator."

kustomize build github.com/redhat-cop/gitops-catalog/advanced-cluster-management/operator/overlays/release-2.9 | oc apply -f -

echo "Pause $SLEEP_SECONDS seconds for the creation of the rhacm-operator..."
sleep $SLEEP_SECONDS

echo "Waiting for operator to start"
until oc get deployment multiclusterhub-operator -n open-cluster-management
do
  sleep 10;
done

echo "Installing the MultiClusterHub"

kustomize build github.com/redhat-cop/gitops-catalog/advanced-cluster-management/instance/base | oc apply -f -

echo "Waiting for hub to be installed"

until [[ $(oc get multiclusterhub multiclusterhub -n open-cluster-management -o jsonpath='{.status.phase}') == 'Running' ]]
do
  echo "Waiting for hub, current status:"
  oc get multiclusterhub multiclusterhub -n open-cluster-management
  sleep 10
done

echo "Installing policies and initial secrets"

kustomize build bootstrap/secrets/base | oc apply -f -
kustomize build bootstrap/policies/overlays/default --enable-alpha-plugins | oc apply -f -

echo "Labeling cluster with 'gitops: local.home'"
oc label managedcluster local-cluster gitops=local.hub --overwrite=true

echo "Check policy compliance with the following command:"
echo "  oc get policy -A"

echo "Once GitOps configuration is complete you may need to run the following to fix Unknown status\n"
echo "  oc delete secret local-cluster-import -n local-cluster\n"
