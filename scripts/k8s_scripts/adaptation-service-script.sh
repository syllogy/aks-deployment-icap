#!/bin/bash

# This script will run commands need to stand up the adaptation service with a cluster.

# Variables
DOCKER_SERVER="https://index.docker.io/v1/"
USER_EMAIL="mpigram@glasswallsolutions.com"
DOCKER_USERNAME=$(az keyvault secret show --name DH-SA-USERNAME --vault-name gw-tfstate-Vault --query value -o tsv)
DOCKER_PASSWORD=$(az keyvault secret show --name DH-SA-password --vault-name gw-tfstate-Vault --query value -o tsv)
NAMESPACE="TEST"

# $(kubectl create ns icap-adaptation-$RANDOM | awk '{print $1}' | cut -c 11-)

# Create namespace for deployment (random string used)
kubectl create ns $NAMESPACE

# Create secret for Docker Registry 
kubectl create -n $NAMESPACE secret docker-registry TEST \
	--docker-server=$DOCKER_SERVER \
	--docker-username=$DOCKER_USERNAME \
	--docker-password=$DOCKER_PASSWORD \
	--docker-email=""

# Install cluster components
helm install ./pod-creations/icap-infrastructure/adaptation --namespace $NAMESPACE --generate-name

sleep 20

kubectl exec rabbitmq-controller- -- /bin/bash -c "rabbitmq-plugins enable rabbitmq_management"

