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
data "azurerm_kubernetes_cluster" "icap-deploy" {
  name                = var.cluster_name
  resource_group_name = var.resource_group
}

# Get cluster host, certs etc
provider "helm" {
  kubernetes {
    config_path            = var.config_path
    host                   = data.azurerm_kubernetes_cluster.icap-deploy.kube_config.0.host
  }
}

# Deploy helm chart
resource "helm_release" "adaptation" {
  name             = var.release_name
  namespace        = var.namespace
  create_namespace = true
  chart            = var.chart_path
  wait             = true
  cleanup_on_fail  = true
  
  set {
        name  = "secrets"
        value = "null"
    }
}