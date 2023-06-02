kustomize build bootstrap/secrets/base | oc apply -f
kustomize build bootstrap/aggregate/overlays/policies-and-secrets | oc apply -f -
