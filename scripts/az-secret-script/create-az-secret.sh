#!/bin/bash

# Vault Variables
NEU_VAULT="icap-neu-keyvault"
UKS_VAULT="icap-uks-keyvault"
QA_VAULT="icap-qa-uks-keyvault"
USEAST_VAULT="icap-qa-useast-keyvault"
UKS_DINIS_NEW_VAULT="icap-dinis-keyvault"

# Secret Name Variables
SECRET_NAME01="DH-SA-USERNAME"
SECRET_NAME02="DH-SA-PASSWORD"
SECRET_NAME03="token-username"
SECRET_NAME04="token-password"
SECRET_NAME05="token-secret"

# Secret Values Variables
DOCKER_USERNAME=$(az keyvault secret show --name DH-SA-USERNAME --vault-name gw-tfstate-Vault --query value -o tsv)
DOCKER_PASSWORD=$(az keyvault secret show --name DH-SA-PASSWORD --vault-name gw-tfstate-Vault --query value -o tsv)
TOKEN_USERNAME=$(az keyvault secret show --name token-username --vault-name gw-tfstate-Vault --query value -o tsv)
TOKEN_PASSWORD=$(tr -dc 'A-Za-z0-9!' </dev/urandom | head -c 20  ; echo)
TOKEN_SECRET=$(tr -dc 'A-Za-z0-9!' </dev/urandom | head -c 30  ; echo)

# AZ Command to set Secrets
az keyvault secret set --vault-name $NEU_VAULT --name $SECRET_NAME01 --value $DOCKER_USERNAME

az keyvault secret set --vault-name $NEU_VAULT --name $SECRET_NAME02 --value $DOCKER_PASSWORD

az keyvault secret set --vault-name $NEU_VAULT --name $SECRET_NAME03 --value $TOKEN_USERNAME

az keyvault secret set --vault-name $NEU_VAULT --name $SECRET_NAME04 --value $TOKEN_PASSWORD

az keyvault secret set --vault-name $NEU_VAULT --name $SECRET_NAME05 --value $TOKEN_SECRET

# AZ Command to set Secrets
az keyvault secret set --vault-name $UKS_VAULT --name $SECRET_NAME01 --value $DOCKER_USERNAME

az keyvault secret set --vault-name $UKS_VAULT --name $SECRET_NAME02 --value $DOCKER_PASSWORD

az keyvault secret set --vault-name $UKS_VAULT --name $SECRET_NAME03 --value $TOKEN_USERNAME

az keyvault secret set --vault-name $UKS_VAULT --name $SECRET_NAME04 --value $TOKEN_PASSWORD

az keyvault secret set --vault-name $UKS_VAULT --name $SECRET_NAME05 --value $TOKEN_SECRET

# AZ Command to set Secrets
az keyvault secret set --vault-name $QA_VAULT --name $SECRET_NAME01 --value $DOCKER_USERNAME

az keyvault secret set --vault-name $QA_VAULT --name $SECRET_NAME02 --value $DOCKER_PASSWORD

az keyvault secret set --vault-name $QA_VAULT --name $SECRET_NAME03 --value $TOKEN_USERNAME

az keyvault secret set --vault-name $QA_VAULT --name $SECRET_NAME04 --value $TOKEN_PASSWORD

az keyvault secret set --vault-name $QA_VAULT --name $SECRET_NAME05 --value $TOKEN_SECRET

# AZ Command to set Secrets
az keyvault secret set --vault-name $USEAST_VAULT --name $SECRET_NAME01 --value $DOCKER_USERNAME

az keyvault secret set --vault-name $USEAST_VAULT --name $SECRET_NAME02 --value $DOCKER_PASSWORD

az keyvault secret set --vault-name $USEAST_VAULT --name $SECRET_NAME03 --value $TOKEN_USERNAME

az keyvault secret set --vault-name $USEAST_VAULT --name $SECRET_NAME04 --value $TOKEN_PASSWORD

az keyvault secret set --vault-name $USEAST_VAULT --name $SECRET_NAME05 --value $TOKEN_SECRET

# AZ Command to set Secrets
az keyvault secret set --vault-name $UKS_DINIS_NEW_VAULT --name $SECRET_NAME01 --value $DOCKER_USERNAME

az keyvault secret set --vault-name $UKS_DINIS_NEW_VAULT --name $SECRET_NAME02 --value $DOCKER_PASSWORD

az keyvault secret set --vault-name $UKS_DINIS_NEW_VAULT --name $SECRET_NAME03 --value $TOKEN_USERNAME

az keyvault secret set --vault-name $UKS_DINIS_NEW_VAULT --name $SECRET_NAME04 --value $TOKEN_PASSWORD

az keyvault secret set --vault-name $UKS_DINIS_NEW_VAULT --name $SECRET_NAME05 --value $TOKEN_SECRET