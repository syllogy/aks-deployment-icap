#!/bin/sh

# Cluster Resource Group Variables
UKS_RESOURCE_GROUP="gw-icap-aks-uks-develop"
NEU_RESOURCE_GROUP="gw-icap-aks-neu-main"
USEAST_RESOURCE_GROUP="gw-icap-aks-useast-main"
QA_UKS_RESOURCE_GROUP="gw-icap-uks-qa-main"

# Cluster FQDN Variables
UKS_CLUSTER_FQDN=$(az aks list -g $UKS_RESOURCE_GROUP --query "[].fqdn" | awk 'FNR == 2' | tr -d '",\040')
NEU_CLUSTER_FQDN=$(az aks list -g $NEU_RESOURCE_GROUP --query "[].fqdn" | awk 'FNR == 2' | tr -d '",\040')
USEAST_CLUSTER_FQDN=$(az aks list -g $USEAST_RESOURCE_GROUP --query "[].fqdn" | awk 'FNR == 2' | tr -d '",\040')
QA_UKS_CLUSTER_FQDN=$(az aks list -g $QA_UKS_RESOURCE_GROUP --query "[].fqdn" | awk 'FNR == 2' | tr -d '",\040')

# App Name
ADAPTATION_SERVICE="icap-adaptation-service"
ADMINISTRATION_SERVICE="icap-administration-service"
NCFS_SERVICE="icap-ncfs-service"
RABBITMQ_OPERATOR="rabbitmq-operator"

# Cluster Context
NEU_CONTEXT="gw-icap-neu-main"
UKS_CONTEXT="gw-icap-uks-develop"
QA_UKS_CONTEXT="gw-icap-uks-qa-main"
USEAST_CONTEXT="gw-icap-useast-main"

# App Paths
PATH_ADAPTATION="adaptation"
PATH_ADMINISTRATION="administration"
PATH_NCFS="ncfs"
PATH_RABBITMQ="rabbitmq-operator"

# Namespaces
NS_ADAPTATION="icap-adaptation"
NS_ADMINISTRATION="icap-administration"
NS_NCFS="icap-ncfs"
NS_RABBIT="default"

# Revisions
REV_MAIN="main"
REV_DEVELOP="develop"

# Parameters
PARAM_REMOVE_SECRETS="secrets=null"

# Github repo
ICAP_REPO="https://github.com/filetrust/icap-infrastructure"

# Add Cluster
argocd cluster add $NEU_CONTEXT
argocd cluster add $UKS_CONTEXT
argocd cluster add $QA_UKS_CONTEXT
argocd cluster add $USEAST_CONTEXT

# Create NEU Cluster Apps
argocd app create $RABBITMQ_OPERATOR-neu-main --repo $ICAP_REPO --path $PATH_RABBITMQ --dest-server https://$NEU_CLUSTER_FQDN:443 --dest-namespace $NS_RABBIT --revision $REV_MAIN

argocd app create $ADAPTATION_SERVICE-neu-main --repo $ICAP_REPO --path $PATH_ADAPTATION --dest-server https://$NEU_CLUSTER_FQDN:443 --dest-namespace $NS_ADAPTATION --revision $REV_MAIN

argocd app create $ADMINISTRATION_SERVICE-neu-main --repo $ICAP_REPO --path $PATH_ADMINISTRATION --dest-server https://$NEU_CLUSTER_FQDN:443 --dest-namespace $NS_ADMINISTRATION --revision $REV_MAIN

argocd app create $PATH_NCFS-neu-main --repo $ICAP_REPO --path $PATH_NCFS --dest-server https://$NEU_CLUSTER_FQDN:443 --dest-namespace $NS_NCFS --revision $REV_MAIN

# # Create UKS Cluster Apps
argocd app create $RABBITMQ_OPERATOR-uks-develop --repo $ICAP_REPO --path $PATH_RABBITMQ --dest-server https://$UKS_CLUSTER_FQDN:443 --dest-namespace $NS_RABBIT --revision $REV_DEVELOP

argocd app create $ADAPTATION_SERVICE-uks-develop --repo $ICAP_REPO --path $PATH_ADAPTATION --dest-server https://$UKS_CLUSTER_FQDN:443 --dest-namespace $NS_ADAPTATION --revision $REV_DEVELOP --parameter $PARAM_REMOVE_SECRETS

# argocd app create $ADMINISTRATION_SERVICE-uks-develop --repo $ICAP_REPO --path $PATH_ADMINISTRATION --dest-server https://$UKS_CLUSTER_FQDN:443 --dest-namespace $NS_ADMINISTRATION --revision $REV_DEVELOP

# argocd app create $PATH_NCFS-uks-develop --repo $ICAP_REPO --path $PATH_NCFS --dest-server https://$UKS_CLUSTER_FQDN:443 --dest-namespace $NS_NCFS --revision $REV_DEVELOP

# Create QA-UKS Cluster Apps
argocd app create $RABBITMQ_OPERATOR-qa-main --repo $ICAP_REPO --path $PATH_RABBITMQ --dest-server https://$QA_UKS_CLUSTER_FQDN:443 --dest-namespace $NS_RABBIT --revision $REV_MAIN

argocd app create $ADAPTATION_SERVICE-qa-main --repo $ICAP_REPO --path $PATH_ADAPTATION --dest-server https://$QA_UKS_CLUSTER_FQDN:443 --dest-namespace $NS_ADAPTATION --revision $REV_MAIN

argocd app create $ADMINISTRATION_SERVICE-qa-main --repo $ICAP_REPO --path $PATH_ADMINISTRATION --dest-server https://$QA_UKS_CLUSTER_FQDN:443 --dest-namespace $NS_ADMINISTRATION --revision $REV_MAIN

argocd app create $PATH_NCFS-qa-main --repo $ICAP_REPO --path $PATH_NCFS --dest-server https://$QA_UKS_CLUSTER_FQDN:443 --dest-namespace $NS_NCFS --revision $REV_MAIN

# Create USEAST Cluster Apps
argocd app create $RABBITMQ_OPERATOR-useast-main --repo $ICAP_REPO --path $PATH_RABBITMQ --dest-server https://$USEAST_CLUSTER_FQDN:443 --dest-namespace $NS_RABBIT --revision $REV_MAIN

argocd app create $ADAPTATION_SERVICE-useast-main --repo $ICAP_REPO --path $PATH_ADAPTATION --dest-server https://$USEAST_CLUSTER_FQDN:443 --dest-namespace $NS_ADAPTATION --revision $REV_MAIN

argocd app create $ADMINISTRATION_SERVICE-useast-main --repo $ICAP_REPO --path $PATH_ADMINISTRATION --dest-server https://$USEAST_CLUSTER_FQDN:443 --dest-namespace $NS_ADMINISTRATION --revision $REV_MAIN

argocd app create $PATH_NCFS-useast-main --repo $ICAP_REPO --path $PATH_NCFS --dest-server https://$USEAST_CLUSTER_FQDN:443 --dest-namespace $NS_NCFS --revision $REV_MAIN