kustomize build bootstrap/aggregate/overlays/policies-and-secrets | oc apply -f -
oc apply -f sealed-secrets-key.yaml