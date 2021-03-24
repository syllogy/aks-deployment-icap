
# Get cluster host, certs etc
provider "helm" {
  kubernetes {
    host                   = azurerm_kubernetes_cluster.argo-deploy.kube_config.0.host

    client_certificate     = base64decode(azurerm_kubernetes_cluster.argo-deploy.kube_config.0.client_certificate)
    client_key             = base64decode(azurerm_kubernetes_cluster.argo-deploy.kube_config.0.client_key)
    cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.argo-deploy.kube_config.0.cluster_ca_certificate)
    }
}

resource "azurerm_resource_group" "resource_group" {
  name     = var.resource_group
  location = var.region

  tags = {
    created_by         = var.created_by
    deployment_version = "1.3.0"
    environment        = var.environment
  }
}

resource "azurerm_kubernetes_cluster" "argo-deploy" {
  name                = var.cluster_name
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  dns_prefix          = "${var.cluster_name}-k8s"

  default_node_pool {
    name            = var.node_name
    node_count      = 1
    vm_size         = "Standard_DS4_v2"
    os_disk_size_gb = 50
  }

  identity {
    type = "SystemAssigned"
  }

  role_based_access_control {
    enabled = true
  }

  tags = {
    created_by         = var.created_by
    deployment_version = "1.3.0"
    environment        = var.environment
    shutdown_function  = "cluster"
  }
}

# Deploy ArgoCD helm chart
resource "helm_release" "argocd" {
  name             = var.release_name01
  namespace        = var.namespace01
  create_namespace = true
  chart            = var.chart_path01
  wait             = true
  cleanup_on_fail  = true

  depends_on = [ 
    azurerm_kubernetes_cluster.argo-deploy,
   ]
}