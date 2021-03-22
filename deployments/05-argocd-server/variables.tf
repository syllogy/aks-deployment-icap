variable "azure_region" {
  description = "The Azure Region"
  type        = string
}

variable "suffix" {
  description = "This is a consolidated name based on org, environment, region"
  type        = string
}

# variable "domain" {
#   description = "This is a domain of organization"
#   type        = string
# }

# variable "icap_port" {
#     description = "The Azure backend vault name"
#     type = string
# }

# variable "icap_tlsport" {
#     description = "The Azure backend storage account"
#     type = string
# }