# Get cluster host, certs etc
provider "helm" {
  kubernetes {
    host                   = azurerm_kubernetes_cluster.file-drop.kube_config.0.host

    client_certificate     = base64decode(azurerm_kubernetes_cluster.file-drop.kube_config.0.client_certificate)
    client_key             = base64decode(azurerm_kubernetes_cluster.file-drop.kube_config.0.client_key)
    cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.file-drop.kube_config.0.cluster_ca_certificate)
    }
}

resource "azurerm_resource_group" "file_drop_rg" {
  name     = var.resource_group
  location = var.region

  tags = {
    created_by         = var.created_by
    deployment_version = "1.3.0"
    environment        = var.environment
  }
}

resource "azurerm_kubernetes_cluster" "file-drop" {
  name                = var.cluster_name
  location            = azurerm_resource_group.file_drop_rg.location
  resource_group_name = azurerm_resource_group.file_drop_rg.name
  dns_prefix          = "${var.cluster_name}-k8s"

  default_node_pool {
    name            = var.node_name
    node_count      = 1
    vm_size         = "Standard_A4_v2"
    os_disk_size_gb = 40
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
    azure_function     = "cluster"
  }
}

# Deploy File-Drop helm chart
resource "helm_release" "file-drop" {

  count = var.enable_helm_deployment ? 1 : 0

  name             = var.release_name01
  namespace        = var.namespace01
  create_namespace = true
  chart            = var.chart_path01
  wait             = true
  cleanup_on_fail  = true
  
  set {
        name  = "secrets"
        value = "null"
    }
  
  set {
        name  = "nginx.ingress.host"
        value = var.file_drop_dns_name_01
    }

  depends_on = [ 
    azurerm_kubernetes_cluster.file-drop,
    helm_release.cert-manager,
    helm_release.ingress-nginx,
   ]
}

# Deploy Cert-Manager helm chart
resource "helm_release" "cert-manager" {

  count = var.enable_helm_deployment ? 1 : 0

  name             = var.release_name02
  chart            = var.chart_repo02
  wait             = true
  cleanup_on_fail  = true

  depends_on = [ 
    azurerm_kubernetes_cluster.file-drop,
   ]
}

# Deploy Ingress-Nginx helm chart
resource "helm_release" "ingress-nginx" {

  name             = var.release_name03
  namespace        = var.namespace03
  create_namespace = true
  chart            = var.chart_repo03
  wait             = true
  cleanup_on_fail  = true

  set {
        name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/azure-dns-label-name"
        value = var.a_record_02
    }

  depends_on = [ 
    azurerm_kubernetes_cluster.file-drop,
   ]
}

resource "null_resource" "get_kube_context" {

 provisioner "local-exec" {

    command = "az aks get-credentials --resource-group ${var.resource_group} --name ${var.cluster_name} --overwrite-existing"
  }
  
  depends_on = [
    azurerm_kubernetes_cluster.file-drop,
  ]
}

resource "null_resource" "load_k8_secrets" {

 provisioner "local-exec" {

    command = "/bin/bash ../../scripts/k8s_scripts/file-drop-secrets.sh ${var.cluster_name}"
  }

  depends_on = [
    null_resource.get_kube_context,
  ]
}

resource "null_resource" "add_apps_argo" {

  count = var.enable_argocd_pipeline ? 1 : 0

 provisioner "local-exec" {

    command = "/bin/bash ../../scripts/argocd_scripts/fd-argocd-app-deploy.sh ${var.resource_group} ${var.cluster_name} ${var.region} ${var.suffix} ${var.revision} ${var.argocd_cluster_context}"
  }

  depends_on = [
    null_resource.get_kube_context,
  ]
}
