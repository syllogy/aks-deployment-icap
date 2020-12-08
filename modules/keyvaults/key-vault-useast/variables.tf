variable "azure_region" {
  description = "Metadata Azure Region"
  type        = string
  default     = "uksouth"
}

variable "resource_group" {
  description = "Azure Resource Group"
  type        = string
  default     = "gw-icap-useast-keyvault"
}

variable "kv_name" {
  description = "The name of the key vault"
  type        = string
  default     = "icap-qa-useast-keyvault"
}