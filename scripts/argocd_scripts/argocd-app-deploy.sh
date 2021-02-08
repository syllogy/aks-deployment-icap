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
MONITORING_SERVICE="monitoring"
CERT_MANAGER="cert-manager"
FILE_DROP="filedrop"
ELK_STACK="elk-stack"

# Cluster Context
NEU_CONTEXT="gw-icap-neu-main"
UKS_CONTEXT="gw-icap-uks-develop"
QA_UKS_CONTEXT="gw-icap-uks-qa-main"
USEAST_CONTEXT="gw-icap-useast-main"

# App Paths
PATH_ADAPTATION="adaptation"
PATH_ADMINISTRATION="administration"
PATH_NCFS="ncfs"
PATH_CERT="cert-manager-chart"
PATH_RABBITMQ="rabbitmq-operator"
PATH_PROMETHEUS="helm-charts/prometheus/"
PATH_GRAFANA="helm-charts/grafana/"
PATH_FILEDROP="filedrop"
PATH_ELK_STACK="elk-stack"

# Namespaces
NS_ADAPTATION="icap-adaptation"
NS_ADMINISTRATION="icap-administration"
NS_NCFS="icap-ncfs"
NS_RABBIT="icap-rabbit-operator"
NS_MONITORING="icap-central-monitoring"
NS_FILEDROP="icap-filedrop"
NS_ELK_STACK="icap-elk-stack"

# Revisions
REV_MAIN="main"
REV_DEVELOP="develop"

# Parameters
PARAM_REMOVE_SECRETS="secrets=null"

PARAM_NEU_ICAP_DNS="lbService.dnsname=icap-client-neu-main"
PARAM_NEU_MGMT_DNS_01="managementui.ingress.host=management-ui-neu-main.northeurope.cloudapp.azure.com"
PARAM_NEU_MGMT_DNS_02="identitymanagementservice.configuration.ManagementUIEndpoint=management-ui-neu-main.northeurope.cloudapp.azure.com"
PARAM_NEU_FILEDROP_DNS="nginx.ingress.host=file-drop-neu-main.northeurope.cloudapp.azure.com"

PARAM_UKS_ICAP_DNS="lbService.dnsname=icap-client-uks-develop"
PARAM_UKS_MGMT_DNS_01="managementui.ingress.host=management-ui-uks-develop.uksouth.cloudapp.azure.com"
PARAM_UKS_MGMT_DNS_02="identitymanagementservice.configuration.ManagementUIEndpoint=management-ui-uks-develop.uksouth.cloudapp.azure.com"
PARAM_UKS_FILEDROP_DNS="nginx.ingress.host=file-drop-uks-develop.uksouth.cloudapp.azure.com"

PARAM_QA_UKS_ICAP_DNS="lbService.dnsname=icap-client-qa-uks"
PARAM_QA_UKS_MGMT_DNS_01="managementui.ingress.host=management-ui-qa-uks.uksouth.cloudapp.azure.com"
PARAM_QA_UKS_MGMT_DNS_02="identitymanagementservice.configuration.ManagementUIEndpoint=management-ui-qa-uks.uksouth.cloudapp.azure.com"
PARAM_QA_UKS_FILEDROP_DNS="nginx.ingress.host=file-drop-qa-uks.uksouth.cloudapp.azure.com"

PARAM_USEAST_ICAP_DNS="lbService.dnsname=icap-client-useast-main"
PARAM_USEAST_MGMT_DNS_01="managementui.ingress.host=management-ui-useast-main.useast.cloudapp.azure.com"
PARAM_USEAST_MGMT_DNS_02="identitymanagementservice.configuration.ManagementUIEndpoint=management-ui-useast-main.useast.cloudapp.azure.com"
PARAM_NEU_FILEDROP_DNS="nginx.ingress.host=file-drop-useast-main.useast.cloudapp.azure.com"

# Github repo
ICAP_REPO="https://github.com/filetrust/icap-infrastructure"

# Switch to argo context
argocd context argo-command-server

# Add Cluster
argocd cluster add $NEU_CONTEXT
argocd cluster add $UKS_CONTEXT
argocd cluster add $QA_UKS_CONTEXT
argocd cluster add $USEAST_CONTEXT

# Create NEU Cluster Apps
argocd app create $RABBITMQ_OPERATOR-neu-main --repo $ICAP_REPO --path $PATH_RABBITMQ --dest-server https://$NEU_CLUSTER_FQDN:443 --dest-namespace $NS_RABBIT --revision $REV_MAIN --parameter $PARAM_REMOVE_SECRETS --sync-policy automated --auto-prune

argocd app create $ADAPTATION_SERVICE-neu-main --repo $ICAP_REPO --path $PATH_ADAPTATION --dest-server https://$NEU_CLUSTER_FQDN:443 --dest-namespace $NS_ADAPTATION --revision $REV_MAIN --parameter $PARAM_REMOVE_SECRETS --parameter $PARAM_NEU_ICAP_DNS --sync-policy automated --auto-prune

argocd app create $ADMINISTRATION_SERVICE-neu-main --repo $ICAP_REPO --path $PATH_ADMINISTRATION --dest-server https://$NEU_CLUSTER_FQDN:443 --dest-namespace $NS_ADMINISTRATION --revision $REV_MAIN --parameter $PARAM_REMOVE_SECRETS --parameter $PARAM_NEU_MGMT_DNS_01 --parameter $PARAM_NEU_MGMT_DNS_02 --sync-policy automated --auto-prune

argocd app create $FILE_DROP-neu-main --repo $ICAP_REPO --path $PATH_FILEDROP --dest-server https://$NEU_CLUSTER_FQDN:443 --dest-namespace $NS_FILEDROP --revision $REV_MAIN --parameter $PARAM_REMOVE_SECRETS --parameter $PARAM_NEU_FILEDROP_DNS --sync-policy automated --auto-prune

argocd app create $ELK_STACK-neu-main --repo $ICAP_REPO --path $PATH_ELK_STACK --dest-server https://$NEU_CLUSTER_FQDN:443 --dest-namespace $NS_ELK_STACK --revision $REV_MAIN --parameter $PARAM_REMOVE_SECRETS --sync-policy automated --auto-prune

argocd app create $PATH_NCFS-neu-main --repo $ICAP_REPO --path $PATH_NCFS --dest-server https://$NEU_CLUSTER_FQDN:443 --dest-namespace $NS_NCFS --revision $REV_MAIN --parameter $PARAM_REMOVE_SECRETS --sync-policy automated --auto-prune

argocd app create $CERT_MANAGER-neu-main --repo $ICAP_REPO --path $PATH_CERT --dest-server https://$NEU_CLUSTER_FQDN:443 --dest-namespace default --revision $REV_MAIN --sync-policy automated --auto-prune

# argocd app create $MONITORING_SERVICE-prometheus-main --repo $ICAP_REPO --path $PATH_PROMETHEUS --dest-server https://$NEU_CLUSTER_FQDN:443 --dest-namespace $NS_MONITORING --revision $REV_DEVELOP

# argocd app create $MONITORING_SERVICE-grafana-main --repo $ICAP_REPO --path $PATH_GRAFANA --dest-server https://$NEU_CLUSTER_FQDN:443 --dest-namespace $NS_MONITORING --revision $REV_DEVELOP

# # Create UKS Cluster Apps
argocd app create $RABBITMQ_OPERATOR-uks-develop --repo $ICAP_REPO --path $PATH_RABBITMQ --dest-server https://$UKS_CLUSTER_FQDN:443 --dest-namespace $NS_RABBIT --revision $REV_DEVELOP --parameter $PARAM_REMOVE_SECRETS --sync-policy automated --auto-prune

argocd app create $ADAPTATION_SERVICE-uks-develop --repo $ICAP_REPO --path $PATH_ADAPTATION --dest-server https://$UKS_CLUSTER_FQDN:443 --dest-namespace $NS_ADAPTATION --revision $REV_DEVELOP --parameter $PARAM_REMOVE_SECRETS --parameter $PARAM_UKS_ICAP_DNS --sync-policy automated --auto-prune

argocd app create $ADMINISTRATION_SERVICE-uks-develop --repo $ICAP_REPO --path $PATH_ADMINISTRATION --dest-server https://$UKS_CLUSTER_FQDN:443 --dest-namespace $NS_ADMINISTRATION --revision $REV_DEVELOP --parameter $PARAM_REMOVE_SECRETS --parameter $PARAM_UKS_MGMT_DNS_01 --parameter $PARAM_UKS_MGMT_DNS_02 --sync-policy automated --auto-prune

argocd app create $FILE_DROP-uks-develop --repo $ICAP_REPO --path $PATH_FILEDROP --dest-server https://$UKS_CLUSTER_FQDN:443 --dest-namespace $NS_FILEDROP --revision $REV_DEVELOP --parameter $PARAM_REMOVE_SECRETS --parameter $PARAM_UKS_FILEDROP_DNS --sync-policy automated --auto-prune

argocd app create $ELK_STACK-uks-develop --repo $ICAP_REPO --path $PATH_ELK_STACK --dest-server https://$UKS_CLUSTER_FQDN:443 --dest-namespace $NS_ELK_STACK --revision $REV_DEVELOP --parameter $PARAM_REMOVE_SECRETS --sync-policy automated --auto-prune

argocd app create $PATH_NCFS-uks-develop --repo $ICAP_REPO --path $PATH_NCFS --dest-server https://$UKS_CLUSTER_FQDN:443 --dest-namespace $NS_NCFS --revision $REV_DEVELOP --parameter $PARAM_REMOVE_SECRETS --sync-policy automated --auto-prune

argocd app create $CERT_MANAGER-uks-develop --repo $ICAP_REPO --path $PATH_CERT --dest-server https://$UKS_CLUSTER_FQDN:443 --dest-namespace default --revision $REV_DEVELOP --sync-policy automated --auto-prune

# argocd app create $MONITORING_SERVICE-uks-develop --repo $ICAP_REPO --path $PATH_PROMETHEUS --dest-server https://$UKS_CLUSTER_FQDN:443 --dest-namespace $NS_MONITORING --revision $REV_DEVELOP

# argocd app create $MONITORING_SERVICE-grafana-uks-develop --repo $ICAP_REPO --path $PATH_GRAFANA --dest-server https://$UKS_CLUSTER_FQDN:443 --dest-namespace $NS_MONITORING --revision $REV_DEVELOP

# # Create QA-UKS Cluster Apps
# argocd app create $RABBITMQ_OPERATOR-qa-main --repo $ICAP_REPO --path $PATH_RABBITMQ --dest-server https://$QA_UKS_CLUSTER_FQDN:443 --dest-namespace $NS_RABBIT --revision $REV_MAIN --parameter $PARAM_REMOVE_SECRETS

# argocd app create $ADAPTATION_SERVICE-qa-main --repo $ICAP_REPO --path $PATH_ADAPTATION --dest-server https://$QA_UKS_CLUSTER_FQDN:443 --dest-namespace $NS_ADAPTATION --revision $REV_MAIN --parameter $PARAM_REMOVE_SECRETS

# argocd app create $ADMINISTRATION_SERVICE-qa-main --repo $ICAP_REPO --path $PATH_ADMINISTRATION --dest-server https://$QA_UKS_CLUSTER_FQDN:443 --dest-namespace $NS_ADMINISTRATION --revision $REV_MAIN --parameter $PARAM_REMOVE_SECRETS

# argocd app create $PATH_NCFS-qa-main --repo $ICAP_REPO --path $PATH_NCFS --dest-server https://$QA_UKS_CLUSTER_FQDN:443 --dest-namespace $NS_NCFS --revision $REV_MAIN --parameter $PARAM_REMOVE_SECRETS

# argocd app create $CERT_MANAGER-qa-main --repo $ICAP_REPO --path $PATH_CERT --dest-server https://$QA_UKS_CLUSTER_FQDN:443 --dest-namespace default --revision $REV_DEVELOP

# argocd app create $MONITORING_SERVICE --repo $ICAP_REPO --path $PATH_PROMETHEUS --dest-server https://$QA_UKS_CLUSTER_FQDN:443 --dest-namespace $NS_MONITORING --revision $REV_MAIN --parameter $PARAM_REMOVE_SECRETS

# argocd app create $MONITORING_SERVICE --repo $ICAP_REPO --path $PATH_GRAFANA --dest-server https://$QA_UKS_CLUSTER_FQDN:443 --dest-namespace $NS_MONITORING --revision $REV_MAIN --parameter $PARAM_REMOVE_SECRETS

# # Create USEAST Cluster Apps
# argocd app create $RABBITMQ_OPERATOR-useast-main --repo $ICAP_REPO --path $PATH_RABBITMQ --dest-server https://$USEAST_CLUSTER_FQDN:443 --dest-namespace $NS_RABBIT --revision $REV_MAIN --parameter $PARAM_REMOVE_SECRETS

# argocd app create $ADAPTATION_SERVICE-useast-main --repo $ICAP_REPO --path $PATH_ADAPTATION --dest-server https://$USEAST_CLUSTER_FQDN:443 --dest-namespace $NS_ADAPTATION --revision $REV_MAIN --parameter $PARAM_REMOVE_SECRETS

# argocd app create $ADMINISTRATION_SERVICE-useast-main --repo $ICAP_REPO --path $PATH_ADMINISTRATION --dest-server https://$USEAST_CLUSTER_FQDN:443 --dest-namespace $NS_ADMINISTRATION --revision $REV_MAIN --parameter $PARAM_REMOVE_SECRETS

# argocd app create $PATH_NCFS-useast-main --repo $ICAP_REPO --path $PATH_NCFS --dest-server https://$USEAST_CLUSTER_FQDN:443 --dest-namespace $NS_NCFS --revision $REV_MAIN --parameter $PARAM_REMOVE_SECRETS

# argocd app create $CERT_MANAGER-neu-test --repo $ICAP_REPO --path $PATH_CERT --dest-server https://$USEAST_CLUSTER_FQDN:443 --dest-namespace default --revision $REV_MAIN --parameter $PARAM_REMOVE_SECRETS

# argocd app create $MONITORING_SERVICE-neu-test --repo $ICAP_REPO --path $PATH_PROMETHEUS --dest-server https://$USEAST_CLUSTER_FQDN:443 --dest-namespace default --revision $REV_MAIN --parameter $PARAM_REMOVE_SECRETS

# argocd app create $MONITORING_SERVICE-neu-test --repo $ICAP_REPO --path $PATH_GRAFANA --dest-server https://$USEAST_CLUSTER_FQDN:443 --dest-namespace default --revision $REV_MAIN --parameter $PARAM_REMOVE_SECRETS