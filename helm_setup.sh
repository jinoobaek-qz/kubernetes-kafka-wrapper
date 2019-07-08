#!/usr/bin/env bash
set -o
set -x

kubectl apply -f - <<EOF
apiVersion: v1
kind: ServiceAccount
metadata:
  name: tiller
  namespace: kube-system
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: tiller
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
  - kind: ServiceAccount
    name: tiller
    namespace: kube-system
EOF

helm init --tiller-tls \
--override 'spec.template.spec.containers[0].command'='{/tiller,--storage=secret}' \
 --tiller-tls-cert $(helm home)/tiller.cert.pem \
--tiller-tls-key $(helm home)/tiller.key.pem \
--tiller-tls-verify \
--tls-ca-cert $(helm home)/ca.pem \
--service-account=tiller

#helm ls --tls --tls-ca-cert ca.cert.pem --tls-cert helm.cert.pem --tls-key helm.key.pem

#cp ca.cert.pem $(helm home)/ca.pem
#cp helm.cert.pem $(helm home)/cert.pem
#cp helm.key.pem $(helm home)/key.pem
helm ls --tls
