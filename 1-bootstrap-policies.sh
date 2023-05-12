kustomize build bootstrap/aggregate/overlays/policies-and-secrets | oc apply -f -
oc apply -f sealed-secrets-key.yaml
oc apply -f eso-token-cluster-hub-secret.yaml
oc apply -f eso-token-cluster-home-secret.yaml
