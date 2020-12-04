variable "resource_group_name" {
  description = "This is a consolidated name based on org, environment, region"
  type        = string
  default 	  = "gw-icap-neu-storage"
}

variable "region" {
  description = "The Azure Region/location the resource will be installed"
  type        = string
  default     = "NORTHEUROPE"
}