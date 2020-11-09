#!/bin/bash

NAMESPACE=prometheus-stack
POD_NAME=$(kubectl get pods -o=name -n "${NAMESPACE}" | grep grafana | cut -f2 -d\/)

kubectl exec -it -n "${NAMESPACE}" "${POD_NAME}" -- /bin/sh -c "/usr/share/grafana/bin/grafana-cli admin reset-admin-password ${POD_NAME}"

exit
