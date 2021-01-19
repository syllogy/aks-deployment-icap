variable "azure_region" {
  description = "Metadata Azure Region"
  type        = string
  default     = "UKSOUTH"
}

variable "resource_group" {
  description = "Azure Resource Group"
  type        = string
  default     = "gw-icap-dinis-new-keyvault"
}

variable "kv_name" {
  description = "The name of the key vault"
  type        = string
  default     = "icap-dinis-keyvault"
}