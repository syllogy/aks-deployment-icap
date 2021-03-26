# Cluster Variables
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
## FIle-Drop Chart
variable "release_name01" {
  description = "This is the name of the release"
  type        = string
  default 	  = "file-drop"
}

variable "namespace01" {
  description = "This is the name of the namespace"
  type        = string
  default 	  = "icap-file-drop"
}

variable "chart_path01" {
  description = "This is the path to the chart"
  type        = string
  default 	  = "../../charts/icap-infrastructure/filedrop"
}

variable "file_drop_dns_name_01" {
  description = "This is the DNS name for the ingress"
  type        = string
  default     = ""
}

variable "a_record_02" {
  description = "A record for File-Drop"
  type = string
  default = ""
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