variable "azure_region" {
  description = "The Azure Region"
  type        = string
}

variable "suffix" {
  description = "This is a consolidated name based on org, environment, region"
  type        = string
}

variable "domain" {
  description = "This is a domain of organization"
  type        = string
}

variable "icap_port" {
  description = "The Azure backend vault name"
  type        = string
}

variable "icap_tlsport" {
  description = "The Azure backend storage account"
  type        = string
}

variable "argocd_cluster_context" {
  description = "The Argocd context name for use with the Argocd CLI"
  type        = string
}

variable "revision" {
  description = "The revision/branch used for ArgoCD"
  type        = string
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