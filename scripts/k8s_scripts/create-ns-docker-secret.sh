#!/bin/bash

# This script will run create the neccesary namespaces and add the docker service account to the required namespace.

# Variables
DOCKER_SERVER="https://index.docker.io/v1/"
USER_EMAIL="mpigram@glasswallsolutions.com"
DOCKER_USERNAME=$(az keyvault secret show --name DH-SA-USERNAME --vault-name gw-tfstate-vault-13222 --query value -o tsv)
DOCKER_PASSWORD=$(az keyvault secret show --name DH-SA-password --vault-name gw-tfstate-vault-13222 --query value -o tsv)
NAMESPACE01="icap-adaptation"
NAMESPACE02="management-ui"
NAMESPACE03="transaction-event-api"
NAMESPACE04="prometheas-stack"
NAMESPACE05="rabbitmq-controller"

# Create namespaces for deployment
kubectl create ns $NAMESPACE01
kubectl create ns $NAMESPACE02
kubectl create ns $NAMESPACE03
kubectl create ns $NAMESPACE04
kubectl create ns $NAMESPACE05

# Create secret for Docker Registry - this only needs to be added to the 'icap-adaptation' namespace 
kubectl create -n $NAMESPACE01 secret docker-registry regcred \
	--docker-server=$DOCKER_SERVER \
	--docker-username=$DOCKER_USERNAME \
	--docker-password="$DOCKER_PASSWORD" \
	--docker-email=$USER_EMAIL

