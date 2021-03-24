variable "azure_region" {
  description = "The Azure Region"
  type        = string
}

variable "suffix" {
  description = "This is a consolidated name based on org, environment, region"
  type        = string
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