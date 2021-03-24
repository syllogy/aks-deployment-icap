variable "region" {
  description = "Metadata Azure Region"
  type        = string
  default     = ""
}

variable "resource_group" {
  description = "Azure Resource Group"
  type        = string
  default     = ""
}

variable "kv_name" {
  description = "The name of the key vault"
  type        = string
  default  = ""
}

variable "icap_dns" {
  description = "Name of the common name used for the certs"
  type        = string
  default     = ""
}

variable "mgmt_dns" {
  description = "Name of the common name used for the certs"
  type        = string
  default     = ""
}

variable "file_drop_dns" {
  description = "Name of the common name used for the certs"
  type        = string
  default     = ""
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