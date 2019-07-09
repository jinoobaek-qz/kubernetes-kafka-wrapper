#!/usr/bin/env bash
set -ex

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

command -v helm || $(echo "Please install helm"; exit)

CERT_FILE="$(helm home)/tiller.cert.pem"
KEY_FILE="$(helm home)/tiller.key.pem"
CA_CERT_FILE="$(helm home)/ca.pem"

if [ -f "$CERT_FILE" ]; then
    echo "$CERT_FILE exist"
else
    echo "$CERT_FILE does not exist"
    exit;
fi

if [ -f "$KEY_FILE" ]; then
    echo "$KEY_FILE exist"
else
    echo "$KEY_FILE does not exist"
    exit;
fi

if [ -f "$CA_CERT_FILE" ]; then
    echo "$CA_CERT_FILE exist"
else
    echo "$CA_CERT_FILE does not exist"
    exit;
fi

helm init --tiller-tls \
--override 'spec.template.spec.containers[0].command'='{/tiller,--storage=secret}' \
--tiller-tls-cert ${CERT_FILE} \
--tiller-tls-key ${KEY_FILE} \
--tiller-tls-verify \
--tls-ca-cert ${CA_CERT_FILE} \
--service-account=tiller \
--wait

helm ls --tls
echo "done with helm setup"
