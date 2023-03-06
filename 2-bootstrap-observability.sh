# Optional to deploy observability component of ACM
# This is a minimal deployment that uses Minio running on my homelab QNAP NAS
kustomize build components/apps/acm/overlays/observability | oc apply -f -