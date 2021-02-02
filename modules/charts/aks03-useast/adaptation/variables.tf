# Provider Variables
variable "resource_group" {
  description = "This is a consolidated name based on org, environment, region"
  type        = string
  default 	  = "gw-icap-aks-useast-main"
}

variable "cluster_name" {
  description = "This is the name of the AKS Cluster"
  type        = string
  default 	  = "gw-icap-useast-main"
}

variable "config_path" {
  description = "This is the path to the kube config"
  type        = string
  default 	  = "~/.kube/config"
}

# Chart Variables
variable "release_name01" {
  description = "This is the name of the release"
  type        = string
  default 	  = "adaptation-service"
}

variable "namespace01" {
  description = "This is the name of the namespace"
  type        = string
  default 	  = "icap-adaptation"
}

variable "chart_path01" {
  description = "This is the path to the chart"
  type        = string
  default 	  = "./pod-creations/icap-infrastructure/adaptation"
}

variable "release_name02" {
  description = "This is the name of the release"
  type        = string
  default 	  = "cert-manager"
}

variable "namespace02" {
  description = "This is the name of the namespace"
  type        = string
  default 	  = "cert-manager"
}

variable "chart_path02" {
  description = "This is the path to the chart"
  type        = string
  default 	  = "./pod-creations/icap-infrastructure/cert-manager-chart"
}

variable "release_name03" {
  description = "This is the name of the release"
  type        = string
  default 	  = "ingress-nginx"
}

variable "namespace03" {
  description = "This is the name of the namespace"
  type        = string
  default 	  = "ingress-nginx"
}

variable "chart_path03" {
  description = "This is the path to the chart"
  type        = string
  default 	  = "./pod-creations/icap-infrastructure/ingress-nginx"
}

variable "release_name04" {
  description = "This is the name of the release"
  type        = string
  default 	  = "administration-service"
}

variable "namespace04" {
  description = "This is the name of the namespace"
  type        = string
  default 	  = "icap-administration"
}

variable "chart_path04" {
  description = "This is the path to the chart"
  type        = string
  default 	  = "./pod-creations/icap-infrastructure/administration"
}