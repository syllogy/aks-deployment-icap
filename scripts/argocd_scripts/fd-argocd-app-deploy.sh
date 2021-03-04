#!/bin/sh

RESOURCE_GROUP=$1
CLUSTER_NAME=$2
REGION=$3
SUFFIX=$4
REVISION=$5
ARGO_CONTEXT=$6
DOMAIN="cloudapp.azure.com"

# Cluster FQDN Variables
CLUSTER_FQDN=$(az aks list -g $RESOURCE_GROUP --query "[].fqdn" | awk 'FNR == 2' | tr -d '",\040')

# App Name
GRAFANA="grafana"
PROMETHEUS="prometheus"
CERT_MANAGER="cert-manager"
FILE_DROP="file-drop"


# App Paths
PATH_CERT="cert-manager-chart"
PATH_PROMETHEUS="helm-charts/prometheus/"
PATH_GRAFANA="helm-charts/grafana/"
PATH_FILEDROP="filedrop"

# Namespaces
NS_CERT_MANAGER="cert-manager"
NS_MONITORING="icap-central-monitoring"
NS_FILEDROP="icap-file-drop"
NS_ELK_STACK="icap-elk-stack"

# Parameters
PARAM_REMOVE_SECRETS="secrets=null"

FILE_DROP_DNS_01="nginx.ingress.host=file-drop-$SUFFIX.$REGION.$DOMAIN"
FILEDROP_DNS="controller.service.annotations.service\\.beta\\.kubernetes\\.io/azure-dns-label-name=file-drop-$SUFFIX.$REGION.$DOMAIN"

# Github repo
ICAP_REPO="https://github.com/filetrust/icap-infrastructure"

# Switch to argo context
argocd context $ARGO_CONTEXT

# Add Cluster
argocd cluster add $CLUSTER_NAME

# Create NEU Cluster Apps
argocd app create $FILE_DROP-$REGION-$REVISION --repo $ICAP_REPO --path $PATH_FILEDROP --dest-server https://$CLUSTER_FQDN:443 --dest-namespace $NS_FILEDROP --revision $REVISION --parameter $PARAM_REMOVE_SECRETS --parameter $FILE_DROP_DNS_01 --sync-policy automated --auto-prune

argocd app create $FILE_DROP-$CERT_MANAGER-$REGION-$REVISION --repo $ICAP_REPO --path $PATH_CERT --dest-server https://$CLUSTER_FQDN:443 --dest-namespace $NS_CERT_MANAGER --revision $REVISION --sync-policy automated --auto-prune

argocd app create $FILE_DROP-$PROMETHEUS-$REGION-develop --repo $ICAP_REPO --path $PATH_PROMETHEUS --dest-server https://$CLUSTER_FQDN:443 --dest-namespace $NS_MONITORING --revision develop --sync-policy automated --auto-prune

argocd app create $FILE_DROP-$GRAFANA-$REGION-develop --repo $ICAP_REPO --path $PATH_GRAFANA --dest-server https://$CLUSTER_FQDN:443 --dest-namespace $NS_MONITORING --revision develop --sync-policy automated --auto-prune