variable "resource_group" {
  description = "This is a consolidated name based on org, environment, region"
  type        = string
  default 	  = ""
}

variable "region" {
  description = "The Azure Region"
  type        = string
  default     = ""
}

variable "cluster_name" {
  description = "This is a consolidated name based on org, environment, region"
  type        = string
  default     = ""
}

variable "node_name" {
  description = "This is the resource group containing the Azure Key Vault"
  type        = string
  default     = "gwicapnode"
}

variable "min_count" {
  description = "This is the minimum node count for the autoscaler"
  type        = string
  default     = ""
}

variable "max_count" {
  description = "This is the maximum node count for the autoscaler"
  type        = string
  default     = ""
}

variable "storage_resource" {
  description = "This is storage_resource"
  type        = string
  default     = ""
}

variable "kv_vault_name" {
  description = "This is kv_vault_name"
  type        = string
  default     = ""
}

variable "argocd_cluster_context" {
  description = "This is the argocd cluster name"
  type        = string
  default     = ""
}

variable "revision" {
  description = "The revision/branch used for ArgoCD"
  type        = string
  default     = ""
}

variable "suffix" {
  description = "This is a consolidated name based on org, environment, region"
  type        = string
  default     = ""
}

variable "enable_argocd_pipeline" {
  description = "The bool to enable the Argocd pipeline"
  type        = bool
  default     = true
}

variable "enable_helm_deployment" {
  description = "The bool to enable the helm deployment"
  type        = bool
  default     = true
}

variable "created_by" {
  description = "The tags for the infrastructure"
  type        = string
  default     = ""
}

variable "environment" {
  description = "The tags for the infrastructure"
  type        = string
  default     = ""
}

variable "argo_ip" {
  description = "The IP for the ArgoCD server"
  type        = string
  default     = ""
}

variable "argo_password" {
  description = "The password for the ArgoCD server"
  type        = string
  default     = ""
}

# Chart Variables
## Adaptation Chart
variable "release_name01" {
  description = "This is the name of the release"
  type        = string
  default 	  = "adaptation-service"
}

variable "namespace01" {
  description = "This is the name of the namespace"
  type        = string
  default 	  = "icap-adaptation"
}

variable "chart_path01" {
  description = "This is the path to the chart"
  type        = string
  default 	  = "../../charts/icap-infrastructure/adaptation"
}

variable "dns_name_01" {
  description = "DNS name for Icap-Service"
  type        = string
  default     = ""
}

variable "icap_port" {
  description = "Public port for the non-tls icap-service"
  type        = string
  default     = ""
}

variable "icap_tlsport" {
  description = "Public port for the tls icap-service"
  type        = string
  default     = ""
}

## Cert-Manager Chart
variable "release_name02" {
  description = "This is the name of the release"
  type        = string
  default 	  = "cert-manager"
}

variable "namespace02" {
  description = "This is the name of the namespace"
  type        = string
  default 	  = "cert-manager"
}

variable "chart_repo02" {
  description = "This is the path to the chart"
  type        = string
  default 	  = "../../charts/icap-infrastructure/cert-manager-chart"
}

## Nginx Chart
variable "release_name03" {
  description = "This is the name of the release"
  type        = string
  default 	  = "ingress-nginx"
}

variable "namespace03" {
  description = "This is the name of the namespace"
  type        = string
  default 	  = "ingress-nginx"
}

variable "chart_repo03" {
  description = "This is the path to the chart"
  type        = string
  default 	  = "../../charts/icap-infrastructure/ingress-nginx"
}

## Administration Chart
variable "release_name04" {
  description = "This is the name of the release"
  type        = string
  default 	  = "administration-service"
}

variable "namespace04" {
  description = "This is the name of the namespace"
  type        = string
  default 	  = "icap-administration"
}

variable "chart_path04" {
  description = "This is the path to the chart"
  type        = string
  default 	  = "../../charts/icap-infrastructure/administration"
}

variable "dns_name_04" {
  description = "DNS name for Management-UI"
  type        = string
  default     = ""
}

variable "a_record_01" {
  description = "A record for Management-UI"
  type        = string
  default     = ""
}

## Rabbitmq-Operator Chart
variable "release_name05" {
  description = "This is the name of the release"
  type        = string
  default 	  = "rabbitmq-operator"
}

variable "namespace05" {
  description = "This is the name of the namespace"
  type        = string
  default 	  = "icap-rabbitmq-operator"
}

variable "chart_path05" {
  description = "This is the path to the chart"
  type        = string
  default 	  = "../../charts/icap-infrastructure/rabbitmq-operator"
}

## Rabbitmq-Operator Chart
variable "release_name06" {
  description = "This is the name of the release"
  type        = string
  default 	  = "icap-ncfs"
}

variable "namespace06" {
  description = "This is the name of the namespace"
  type        = string
  default 	  = "icap-ncfs"
}

variable "chart_path06" {
  description = "This is the path to the chart"
  type        = string
  default 	  = "../../charts/icap-infrastructure/ncfs"
}

## Elk-Stack Charts
variable "release_name07" {
  description = "This is the name of the release"
  type        = string
  default 	  = "icap-elk-stack"
}

variable "namespace07" {
  description = "This is the name of the namespace"
  type        = string
  default 	  = "icap-elk-stack"
}

variable "chart_path07" {
  description = "This is the path to the chart"
  type        = string
  default 	  = "../../charts/icap-infrastructure/elk-stack"
}

## Grafana Chart
variable "release_name08" {
  description = "This is the name of the release"
  type        = string
  default 	  = "icap-grafana"
}

variable "namespace08" {
  description = "This is the name of the namespace"
  type        = string
  default 	  = "icap-central-monitoring"
}

variable "chart_path08" {
  description = "This is the path to the chart"
  type        = string
  default 	  = "../../charts/icap-infrastructure/helm-charts/grafana"
}

## Prometheus Chart
variable "release_name09" {
  description = "This is the name of the release"
  type        = string
  default 	  = "icap-prometheus"
}

variable "namespace09" {
  description = "This is the name of the namespace"
  type        = string
  default 	  = "icap-central-monitoring"
}

variable "chart_path09" {
  description = "This is the path to the chart"
  type        = string
  default 	  = "../../charts/icap-infrastructure/helm-charts/prometheus"
}

## Prometheus Chart
variable "release_name10" {
  description = "This is the name of the release"
  type        = string
  default 	  = "icap-cadvisor"
}

variable "namespace10" {
  description = "This is the name of the namespace"
  type        = string
  default 	  = "icap-central-monitoring"
}

variable "chart_path10" {
  description = "This is the path to the chart"
  type        = string
  default 	  = "../../charts/icap-infrastructure/helm-charts/cadvisor"
}

variable "ip_ranges_01" {
  description = "Whitelisted IP Ranges"
  type        = string
  default     = ""
}