#!/bin/bash

# AKS Variables
NEU_RESOURCE_GROUP="gw-icap-aks-neu-main"
NEU_AKS_NAME="gw-icap-neu-main"
UKS_RESOURCE_GROUP="gw-icap-aks-uks-develop"
UKS_AKS_NAME="gw-icap-uks-develop"
USEAST_RESOURCE_GROUP="gw-icap-aks-useast-main"
USEAST_AKS_NAME="gw-icap-useast-main"
UKS_QA_RESOURCE_GROUP="gw-icap-uks-qa-main"
UKS_QA_AKS_NAME="gw-icap-uks-qa-main"

az aks get-credentials --resource-group $NEU_RESOURCE_GROUP --name $NEU_AKS_NAME

az aks get-credentials --resource-group $UKS_RESOURCE_GROUP --name $UKS_AKS_NAME

az aks get-credentials --resource-group $USEAST_RESOURCE_GROUP --name $USEAST_AKS_NAME

az aks get-credentials --resource-group $UKS_QA_RESOURCE_GROUP --name $UKS_QA_AKS_NAME

