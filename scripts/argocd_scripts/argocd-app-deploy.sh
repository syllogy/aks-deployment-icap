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
ADAPTATION_SERVICE="icap-adaptation-service"
ADMINISTRATION_SERVICE="icap-administration-service"
NCFS_SERVICE="icap-ncfs-service"
RABBITMQ_OPERATOR="rabbitmq-operator"
GRAFANA="grafana"
PROMETHEUS="prometheus"
CERT_MANAGER="cert-manager"
FILE_DROP="filedrop"
ELK_STACK="elk-stack"

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
NS_CERT_MANAGER="cert-manager"
NS_ADMINISTRATION="icap-administration"
NS_NCFS="icap-ncfs"
NS_RABBIT="icap-rabbit-operator"
NS_MONITORING="icap-central-monitoring"
NS_FILEDROP="icap-filedrop"
NS_ELK_STACK="icap-elk-stack"

# Parameters
PARAM_REMOVE_SECRETS="secrets=null"

ICAP_DNS="lbService.dnsname=icap-$SUFFIX"
MGMT_DNS_01="controller.service.annotations.service\\.beta\\.kubernetes\\.io/azure-dns-label-name=management-ui-$SUFFIX.$REGION.$DOMAIN"
MGMT_DNS_02="managementui.ingress.host=management-ui-$SUFFIX.$REGION.$DOMAIN"
IDENTITY_MGMT_DNS_02="identitymanagementservice.configuration.ManagementUIEndpoint=management-ui-$SUFFIX.$REGION.$DOMAIN"
FILEDROP_DNS="controller.service.annotations.service\\.beta\\.kubernetes\\.io/azure-dns-label-name=file-drop-$SUFFIX.$REGION.$DOMAIN"

# Github repo
ICAP_REPO="https://github.com/filetrust/icap-infrastructure"

# Switch to argo context
argocd context $ARGO_CONTEXT

# Add Cluster
argocd cluster add $CLUSTER_NAME

# Create NEU Cluster Apps
argocd app create $RABBITMQ_OPERATOR-$SUFFIX-$REGION-$REVISION --repo $ICAP_REPO --path $PATH_RABBITMQ --dest-server https://$CLUSTER_FQDN:443 --dest-namespace $NS_RABBIT --revision $REVISION --parameter $PARAM_REMOVE_SECRETS --sync-policy automated --auto-prune

argocd app create $ADAPTATION_SERVICE-$SUFFIX-$REGION-$REVISION --repo $ICAP_REPO --path $PATH_ADAPTATION --dest-server https://$CLUSTER_FQDN:443 --dest-namespace $NS_ADAPTATION --revision $REVISION --parameter $PARAM_REMOVE_SECRETS --parameter $ICAP_DNS --sync-policy automated --auto-prune

argocd app create $ADMINISTRATION_SERVICE-$SUFFIX-$REGION-$REVISION --repo $ICAP_REPO --path $PATH_ADMINISTRATION --dest-server https://$CLUSTER_FQDN:443 --dest-namespace $NS_ADMINISTRATION --revision $REVISION --parameter $PARAM_REMOVE_SECRETS --parameter $MGMT_DNS_01 --parameter $IDENTITY_MGMT_DNS_02 --parameter $MGMT_DNS_02 --sync-policy automated --auto-prune

argocd app create $ELK_STACK-$SUFFIX-$REGION-$REVISION --repo $ICAP_REPO --path $PATH_ELK_STACK --dest-server https://$CLUSTER_FQDN:443 --dest-namespace $NS_ELK_STACK --revision $REVISION --parameter $PARAM_REMOVE_SECRETS --sync-policy automated --auto-prune

argocd app create $PATH_NCFS-$SUFFIX-$REGION-$REVISION  --repo $ICAP_REPO --path $PATH_NCFS --dest-server https://$CLUSTER_FQDN:443 --dest-namespace $NS_NCFS --revision $REVISION --parameter $PARAM_REMOVE_SECRETS --sync-policy automated --auto-prune

argocd app create $CERT_MANAGER-$SUFFIX-$REGION-$REVISION  --repo $ICAP_REPO --path $PATH_CERT --dest-server https://$CLUSTER_FQDN:443 --dest-namespace $NS_CERT_MANAGER --revision $REVISION --sync-policy automated --auto-prune

argocd app create $PROMETHEUS-$SUFFIX-$REGION-develop --repo $ICAP_REPO --path $PATH_PROMETHEUS --dest-server https://$CLUSTER_FQDN:443 --dest-namespace $NS_MONITORING --revision develop --sync-policy automated --auto-prune

argocd app create $GRAFANA-$SUFFIX-$REGION-develop --repo $ICAP_REPO --path $PATH_GRAFANA --dest-server https://$CLUSTER_FQDN:443 --dest-namespace $NS_MONITORING --revision develop --sync-policy automated --auto-prune