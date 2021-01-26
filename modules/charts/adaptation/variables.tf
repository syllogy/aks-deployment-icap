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

variable "release_name" {
  description = "This is the name of the release"
  type        = string
  default 	  = "adaptation-service"
}

variable "namespace" {
  description = "This is the name of the namespace"
  type        = string
  default 	  = "icap-adaptation"
}

variable "chart_path" {
  description = "This is the path to the chart"
  type        = string
  default 	  = "./pod-creations/icap-infrastructure/adaptation"
}

variable "config_path" {
  description = "This is the path to the kube config"
  type        = string
  default 	  = "~/.kube/config"
}