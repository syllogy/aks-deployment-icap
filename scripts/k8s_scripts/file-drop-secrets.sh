#!/bin/bash
CLUSTER_NAME=$1
NAMESPACE01="icap-file-drop"
NAMESPACE02="ingress-nginx"
NAMESPACE03="icap-central-monitoring"

kubectl create ns $NAMESPACE01
kubectl create ns $NAMESPACE02
kubectl create ns $NAMESPACE03

kubectl config use-context $CLUSTER_NAME

# Create secret for TLS certs & keys - needs to be part of the 'icap-filedrop' namespace
(cd ./certs/file-drop-cert; kubectl create -n $NAMESPACE01 secret tls tls-certificate-secret --key tls.key --cert certificate.crt)