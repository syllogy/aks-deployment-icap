variable "resource_group_name" {
  description = "This is a consolidated name based on org, environment, region"
  type        = string
  default 	  = "gw-icap-UKS-storage"
}

variable "region" {
  description = "The Azure Region/location the resource will be installed"
  type        = string
  default     = "UKSOUTH"
}

variable "file_share_name01" {
  description = "The name of the file share"
  type        = string
  default     = "transactions"
}

variable "file_share_name02" {
  description = "The name of the file share"
  type        = string
  default     = "policies"
}