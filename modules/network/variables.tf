variable "resource_group" {
  description = "This is a consolidated name based on org, environment, region"
  type        = string
  default         = "gw-icap-aks-deploy"
}

variable "region" {
  description = "The Azure Region"
  type        = string
  default     = "UKSouth"
}

variable "prefix" {
  description = "Default prefix for any service names"
  type        = string
  default     = "gw-icap"
}

variable "service_name" {
  description = "This is a consolidated name based on org, environment, region"
  type		  = string
  default 	  = "gw-icap-vn"
}

variable "address_space" {
  description = "This is the address space"
  type        = list(string)
  default     = ["10.0.0.0/24"]
}
