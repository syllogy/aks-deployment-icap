terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.35.0"
    }
    
    helm = {
      source  = "hashicorp/helm"
      version = "2.0.0"
    }

    null = {
      source  = "hashicorp/null"
      version = "3.0.0"
    }
  }
}

# Get the cluster data
data "azurerm_kubernetes_cluster" "aks03-useast" {
  name                = var.cluster_name
  resource_group_name = var.resource_group
}

# Get cluster host, certs etc
provider "helm" {
  kubernetes {
    config_path       = var.config_path
    host              = data.azurerm_kubernetes_cluster.aks03-useast.kube_config.0.host
  }
}

# # Deploy Adaptation helm chart
# resource "helm_release" "adaptation" {
#   name             = var.release_name01
#   namespace        = var.namespace01
#   create_namespace = true
#   chart            = var.chart_path01
#   wait             = true
#   cleanup_on_fail  = true
  
#   set {
#         name  = "secrets"
#         value = "null"
#     }
# }

# Deploy Cert-Manager helm chart
resource "helm_release" "cert-manager" {
  name             = var.release_name02
  chart            = var.chart_path02
  wait             = true
  cleanup_on_fail  = true
}

# # Deploy Ingress-Nginx helm chart
# resource "helm_release" "ingress-nginx" {
#   name             = var.release_name03
#   namespace        = var.namespace03
#   create_namespace = true
#   chart            = var.chart_path03
#   wait             = true
#   cleanup_on_fail  = true
# }

# # Deploy Administrastion helm chart
# resource "helm_release" "administration" {
#   name             = var.release_name04
#   namespace        = var.namespace04
#   create_namespace = true
#   chart            = var.chart_path04
#   wait             = false
#   cleanup_on_fail  = true
  
#   set {
#         name  = "secrets"
#         value = "null"
#     }
# }