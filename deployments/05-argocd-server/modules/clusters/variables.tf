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
 default      = ""
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

# Chart Variables
## Argocd Chart
variable "release_name01" {
  description = "This is the name of the release"
  type        = string
  default 	  = "argocd"
}

variable "namespace01" {
  description = "This is the name of the namespace"
  type        = string
  default 	  = "argocd"
}

variable "chart_path01" {
  description = "This is the path to the chart"
  type        = string
  default 	  = "../../charts/icap-infrastructure/argocd"
}