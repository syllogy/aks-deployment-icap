variable "resource_group" {
  description = "This is a consolidated name based on org, environment, region"
  type        = string
  default         = "gw-icap-aks-deploy"
}

variable "service_name" {
  description = "The service name"
  type        = string
  default     = "gwicapsubnet"
}

variable "virtual_network_name" {
  description = "This is the virtual network name"
  type        = string
  default     = "gw-icap-vn"
}

variable "address_prefixes" {
  description = "This is a consolidated name based on org, environment, region"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

