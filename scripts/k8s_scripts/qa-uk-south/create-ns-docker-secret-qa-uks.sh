#!/bin/bash

# This script will run create the neccesary namespaces and add the docker service account to the required namespace.

# Variables
DOCKER_SERVER="https://index.docker.io/v1/"
USER_EMAIL="mpigram@glasswallsolutions.com"
DOCKER_USERNAME=$(az keyvault secret show --name DH-SA-USERNAME --vault-name gw-icap-qa-vault --query value -o tsv)
DOCKER_PASSWORD=$(az keyvault secret show --name DH-SA-password --vault-name gw-icap-qa-vault --query value -o tsv)
FILESHARE_ACCOUNT_NAME=$(az storage account list -g gw-icap-tfstate-qa-uks --query "[].name" | awk 'FNR == 2' | tr -d '"[]\040')
FILESHARE_KEY=$(az storage account keys list -g gw-icap-tfstate -n tfstate263 --query "[].value" | awk 'FNR == 2' | tr -d '",\040')
TOKEN_USERNAME=$(az keyvault secret show --name token-username --vault-name gw-icap-qa-vault --query value -o tsv)
TOKEN_PASSWORD=$(tr -dc 'A-Za-z0-9!"#$%&'\''()*+,-./:;<=>?@[\]^_`{|}~' </dev/urandom | head -c 20  ; echo)
TRANSACTION_CSV=$(az storage account show-connection-string -g gw-icap-tfstate-qa-uks -n ukstfstate17126 --query connectionString | tr -d '"')
POLICY_CSV=$(az keyvault secret show --name policy-csv --vault-name gw-icap-qa-vault --query value -o tsv)
NCFS_POLICY_REF=$(az keyvault secret show --name ncfs-policy-ref --vault-name gw-icap-qa-vault --query value -o tsv)


# Namspace Variables
NAMESPACE01="icap-adaptation"
NAMESPACE02="icap-prometheus-stack"
NAMESPACE03="icap-ncfs"
NAMESPACE04="icap-administration"

# Create namespaces for deployment
kubectl create ns $NAMESPACE01
kubectl create ns $NAMESPACE02
kubectl create ns $NAMESPACE03
kubectl create ns $NAMESPACE04

# Create secret for Docker Registry - this only needs to be added to the 'icap-adaptation' namespace
kubectl create -n $NAMESPACE01 secret docker-registry regcred \
	--docker-server=$DOCKER_SERVER \
	--docker-username=$DOCKER_USERNAME \
	--docker-password="$DOCKER_PASSWORD" \
	--docker-email=$USER_EMAIL

# Create secret for policy update service - needs to be part of the 'icap-adaptation' namespace
kubectl create -n $NAMESPACE01 secret generic policyupdateserviceref --from-literal=TokenUsername=$TOKEN_USERNAME --from-literal=TokenPassword=$TOKEN_PASSWORD --from-literal=PolicyUpdateServiceEndpointCsv=$POLICY_CSV

kubectl create -n $NAMESPACE01 secret generic policyupdateservicesecret --from-literal=username=$TOKEN_USERNAME --from-literal=password=$TOKEN_PASSWORD --from-literal=PolicyUpdateServiceEndpointCsv=$POLICY_CSV

kubectl create -n $NAMESPACE01 secret generic ncfspolicyupdateservicesecret --from-literal=username=$TOKEN_USERNAME --from-literal=password=$TOKEN_PASSWORD --from-literal=NcfsPolicyUpdateServiceEndpointCsv=$NCFS_POLICY_REF

kubectl create -n $NAMESPACE01 secret generic ncfspolicyupdateserviceref --from-literal=username=$TOKEN_USERNAME --from-literal=password=$TOKEN_PASSWORD --from-literal=NcfsPolicyUpdateServiceEndpointCsv=$NCFS_POLICY_REF

kubectl create -n $NAMESPACE01 secret generic transactionstoresecret --from-literal=accountName=$FILESHARE_ACCOUNT_NAME --from-literal=accountKey=$FILESHARE_KEY --from-literal=TransactionStoreConnectionStringCsv=$TRANSACTION_CSV

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