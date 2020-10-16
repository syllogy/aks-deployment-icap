variable "organisation" {
  description = "Metadata Organisation"
  type        = string
  default     = "Glasswall"
}

variable "environment" {
  description = "Metadata Environment"
  type        = string
  default     = "test"
}

variable "service_name" {
  description = "This is a consolidated name based on org, environment, region"
  type        = string
  default     = "gw-icap-aks-deploy"
}

variable "service_type" {
  description = "This is consolidated based on the project, type and suffix"
  type        = string
  default     = "gw-icap-pub-ip"
}

variable "region" {
  description = "The Azure Region"
  type        = string
  default     = "UKSouth"
}

variable "resource_group" {
  description = "Azure Resource Group"
  type        = string
  default     = "gw-icap-aks-deploy"
}
