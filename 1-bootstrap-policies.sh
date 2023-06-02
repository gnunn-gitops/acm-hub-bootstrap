kustomize build bootstrap/secrets/base | oc apply -f -
kustomize build bootstrap/policies/overlays/default --enable-alpha-plugins | oc apply -f -
