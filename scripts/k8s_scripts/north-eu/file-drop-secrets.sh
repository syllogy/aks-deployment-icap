#!/bin/bash

kubectl config use-context gw-icap-neu-file-drop-main

NAMESPACE01="icap-filedrop"

kubectl create ns $NAMESPACE01

# Create secret for TLS certs & keys - needs to be part of the 'icap-filedrop' namespace
(cd ./certs/filedrop-cert; kubectl create -n $NAMESPACE01 secret tls tls-secret --key tls.key --cert certificate.crt)