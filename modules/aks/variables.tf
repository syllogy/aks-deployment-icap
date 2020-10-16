variable "resource_group" {
  description = "This is a consolidated name based on org, environment, region"
  type        = string
  default 	  = "gw-icap-aks-deploy"
}

variable "region" {
  description = "The Azure Region"
  type        = string
  default     = "UKSouth"
}

variable "appId" {
  description = "This is a consolidated name based on org, environment, region"
  type        = string
  default     = "46ab5117-64bf-4b84-8267-8e40bc05624b"
}

variable "password" {
  description = "This is a consolidated name based on org, environment, region"
  type        = string
  default     = "ch-AXQ2B.IOEEV_g4XjUUFh~6u-FvkMpdf"
}

variable "prefix" {
  description = "This is a consolidated name based on org, environment, region"
  type        = string
  default     = "gw-icap"
}
