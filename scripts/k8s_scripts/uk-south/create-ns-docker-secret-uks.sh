#!/bin/bash

# This script will run create the neccesary namespaces and add the docker service account to the required namespace.

# Variables
DOCKER_SERVER="https://index.docker.io/v1/"
USER_EMAIL="mpigram@glasswallsolutions.com"
DOCKER_USERNAME=$(az keyvault secret show --name DH-SA-USERNAME --vault-name gw-tfstate-Vault --query value -o tsv)
DOCKER_PASSWORD=$(az keyvault secret show --name DH-SA-password --vault-name gw-tfstate-Vault --query value -o tsv)
FILESHARE_ACCOUNT_NAME=$(az keyvault secret show --name file-share-account --vault-name gw-tfstate-Vault --query value -o tsv)
FILESHARE_KEY=$(az keyvault secret show --name file-share-key --vault-name gw-tfstate-Vault --query value -o tsv)
TOKEN_USERNAME=$(az keyvault secret show --name token-username --vault-name gw-tfstate-Vault --query value -o tsv)
TOKEN_PASSWORD=$(az keyvault secret show --name token-password --vault-name gw-tfstate-Vault --query value -o tsv)
TRANSACTION_CSV=$(az storage account show-connection-string -g gw-icap-tfstate -n tfstate263 --query connectionString | tr -d '"')
POLICY_CSV=$(az keyvault secret show --name policy-csv --vault-name gw-tfstate-Vault --query value -o tsv)
NCFS_POLICY_REF=$(az keyvault secret show --name ncfs-policy-ref --vault-name gw-tfstate-Vault --query value -o tsv)


# Namspace Variables
NAMESPACE01="icap-adaptation"
NAMESPACE02="icap-prometheus-stack"
NAMESPACE03="icap-ncfs"
NAMESPACE04="icap-administration"
NAMESPACE05="argocd"

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

# Create secrets for the 'icap-adaptation' namespace
kubectl create -n $NAMESPACE01 secret generic policyupdateservicesecret --from-literal=username=$TOKEN_USERNAME --from-literal=password=$TOKEN_PASSWORD

kubectl create -n $NAMESPACE01 secret generic ncfspolicyupdateservicesecret --from-literal=username=$TOKEN_USERNAME --from-literal=password=$TOKEN_PASSWORD

kubectl create -n $NAMESPACE01 secret generic transactionstoresecret --from-literal=accountName=$FILESHARE_ACCOUNT_NAME --from-literal=accountKey=$FILESHARE_KEY

# Create secret for file share - needs to be part of the 'icap-administration' namespace
kubectl create -n $NAMESPACE04 secret generic transactionstoresecret --from-literal=accountName=$FILESHARE_ACCOUNT_NAME --from-literal=accountKey=$FILESHARE_KEY --from-literal=TransactionStoreConnectionStringCsv=$TRANSACTION_CSV

kubectl create -n $NAMESPACE04 secret generic policyupdateserviceref --from-literal=TokenUsername=$TOKEN_USERNAME --from-literal=TokenPassword=$TOKEN_PASSWORD --from-literal=PolicyUpdateServiceEndpointCsv=$POLICY_CSV

kubectl create -n $NAMESPACE04 secret generic policystoresecret --from-literal=accountName=$FILESHARE_ACCOUNT_NAME --from-literal=accountKey=$FILESHARE_KEY

kubectl create -n $NAMESPACE04 secret generic ncfspolicyupdateservicesecret --from-literal=username=$TOKEN_USERNAME --from-literal=password=$TOKEN_PASSWORD --from-literal=NcfsPolicyUpdateServiceEndpointCsv=$NCFS_POLICY_REF

kubectl create -n $NAMESPACE04 secret generic ncfspolicyupdateserviceref --from-literal=username=$TOKEN_USERNAME --from-literal=password=$TOKEN_PASSWORD --from-literal=NcfsPolicyUpdateServiceEndpointCsv=$NCFS_POLICY_REF

# Create secret for file share - needs to be part of the 'icap-ncfs' namespace
kubectl create -n $NAMESPACE03 secret generic transactionstoresecret --from-literal=accountName=$FILESHARE_ACCOUNT_NAME --from-literal=accountKey=$FILESHARE_KEY --from-literal=TransactionStoreConnectionStringCsv=$TRANSACTION_CSV

kubectl create -n $NAMESPACE03 secret generic policystoresecret --from-literal=accountName=$FILESHARE_ACCOUNT_NAME --from-literal=accountKey=$FILESHARE_KEY 

kubectl create -n $NAMESPACE03 secret generic policyupdateserviceref --from-literal=TokenUsername=$TOKEN_USERNAME --from-literal=TokenPassword=$TOKEN_PASSWORD --from-literal=PolicyUpdateServiceEndpointCsv=$POLICY_CSV --from-literal=NcfsPolicyUpdateServiceEndpointCsv=$NCFS_POLICY_REF

kubectl create -n $NAMESPACE03 secret generic ncfspolicyupdateservicesecret --from-literal=username=$TOKEN_USERNAME --from-literal=password=$TOKEN_PASSWORD --from-literal=NcfsPolicyUpdateServiceEndpointCsv=$NCFS_POLICY_REF

kubectl create -n $NAMESPACE03 secret generic ncfspolicyupdateserviceref --from-literal=username=$TOKEN_USERNAME --from-literal=password=$TOKEN_PASSWORD --from-literal=NcfsPolicyUpdateServiceEndpointCsv=$NCFS_POLICY_REF

# Create secret for TLS certs & keys - needs to be part of the 'icap-adaptation' namespace
kubectl create -n $NAMESPACE01 secret tls icap-service-tls-config --key tls.key --cert certificate.crt

#  az storage account list -g gw-icap-tfstate --query "[].name" | tr -d '"[]'