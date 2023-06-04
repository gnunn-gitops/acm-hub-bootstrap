### Introduction

This repository is used to bootstrap the RHACM Hub cluster as well as hold the ACM configuration
I use in my homelab environment. It is referenced by the [cluster-config](https://github.com/gnunn-gitops/cluster-config) repo for the `local.hub` cluster's ACM applications (Hub, Policies and Observerability).

From the perspective of bootstrapping the Hub there are a couple of different ways to go. You could
manually install OpenShift GitOps and have it bootstrap everything. However I'm using ACM to bootstrap
my managed clusters and I wanted to use the exact same workflow if I could for the Hub. This is because
I wanted to avoid having to create a tweaked workflow just for the Hub.

### Bootstrap Process

The bootstrap process, encapsulated in the bootstrap.sh script, is as follows:

1. Install the RHACM operator and wait for it to complete
2. Install the MultiClusterHub custom resource and wait for it to be in the Running phase
3. Deploy all of the RHACM policies including the policy that deploys the OpenShift
GitOps operator with the bootstrap application
4. Label the Hub cluster, `local-cluster`, with the label `gitops=local.hub`. This trigger the
GitOps policy we deployed in step #3 to install OpenShift GitOps on the Hub cluster and
deploy the bootstrap application pointing to the repo and path needed for this cluster, i.e.
`local.home`

At this point the GitOps operator deploys everything the Hub cluster requires including storage, operators, etc
as well as other ACM components. In particular, the components that the script deployed (Hub + Policies) have
Argo applications that will take over managing these.