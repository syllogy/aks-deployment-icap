# Get cluster host, certs etc
provider "helm" {
  kubernetes {
    host                   = azurerm_kubernetes_cluster.icap-deploy.kube_config.0.host

    client_certificate     = base64decode(azurerm_kubernetes_cluster.icap-deploy.kube_config.0.client_certificate)
    client_key             = base64decode(azurerm_kubernetes_cluster.icap-deploy.kube_config.0.client_key)
    cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.icap-deploy.kube_config.0.cluster_ca_certificate)
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

resource "azurerm_kubernetes_cluster" "icap-deploy" {
  name                = var.cluster_name
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  dns_prefix          = "${var.cluster_name}-k8s"

  default_node_pool {
    name            = var.node_name
    node_count      = 4
    vm_size         = "Standard_DS4_v2"
    os_disk_size_gb = 100

    enable_auto_scaling = true
    min_count           = var.min_count
    max_count           = var.max_count
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

# Deploy Adaptation helm chart
resource "helm_release" "adaptation" {

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
        name  = "lbService.nontlsport"
        value = var.icap_port
    }
  
  set {
        name  = "lbService.tlsport"
        value = var.icap_tlsport
    }
  
  set {
        name  = "lbService.dnsname"
        value = var.dns_name_01
    }

  depends_on = [ 
    azurerm_kubernetes_cluster.icap-deploy,
    helm_release.rabbitmq-operator,
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
    azurerm_kubernetes_cluster.icap-deploy,
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
        value = var.a_record_01
    }

  depends_on = [ 
    azurerm_kubernetes_cluster.icap-deploy,
   ]
}

# Deploy Administrastion helm chart
resource "helm_release" "administration" {

  count = var.enable_helm_deployment ? 1 : 0

  name             = var.release_name04
  namespace        = var.namespace04
  create_namespace = true
  chart            = var.chart_path04
  wait             = true
  cleanup_on_fail  = true
  
  set {
        name  = "secrets"
        value = "null"
    }

  set {
        name  = "managementui.ingress.host"
        value = var.dns_name_04
    }

  set {
        name  = "identitymanagementservice.configuration.ManagementUIEndpoint"
        value = var.dns_name_04
    }

  depends_on = [ 
    azurerm_kubernetes_cluster.icap-deploy,
    helm_release.cert-manager,
    helm_release.ingress-nginx,
    null_resource.load_k8_secrets,
   ]
}

# Deploy Rabbitmq-Operator helm chart
resource "helm_release" "rabbitmq-operator" {

  count = var.enable_helm_deployment ? 1 : 0

  name             = var.release_name05
  namespace        = var.namespace05
  create_namespace = true
  chart            = var.chart_path05
  wait             = false
  cleanup_on_fail  = true
  
  set {
        name  = "secrets"
        value = "null"
    }

  depends_on = [ 
    azurerm_kubernetes_cluster.icap-deploy,
   ]
}

# Deploy NCFS helm chart
resource "helm_release" "ncfs" {

  count = var.enable_helm_deployment ? 1 : 0
  
  name             = var.release_name06
  namespace        = var.namespace06
  create_namespace = true
  chart            = var.chart_path06
  wait             = true
  cleanup_on_fail  = true
  
  set {
        name  = "secrets"
        value = "null"
    }

  depends_on = [ 
    azurerm_kubernetes_cluster.icap-deploy,
   ]
}

# Deploy Elk-Stack helm chart
resource "helm_release" "ekl-stack" {

  count = var.enable_helm_deployment ? 1 : 0

  name             = var.release_name07
  namespace        = var.namespace07
  create_namespace = true
  chart            = var.chart_path07
  wait             = true
  cleanup_on_fail  = true
  
  set {
        name  = "secrets"
        value = "null"
    }

  depends_on = [ 
    azurerm_kubernetes_cluster.icap-deploy,
   ]
}

  # Deploy Grafana helm chart
  resource "helm_release" "grafana" {

    count = var.enable_helm_deployment ? 1 : 0

    name             = var.release_name08
    namespace        = var.namespace08
    create_namespace = true
    chart            = var.chart_path08
    wait             = true
    cleanup_on_fail  = true

    depends_on = [ 
      azurerm_kubernetes_cluster.icap-deploy,
    ]
  }

  # Deploy Prometheus helm chart
  resource "helm_release" "prometheus" {

    count = var.enable_helm_deployment ? 1 : 0

    name             = var.release_name09
    namespace        = var.namespace09
    create_namespace = true
    chart            = var.chart_path09
    wait             = true
    cleanup_on_fail  = true

    set {
        name  = "server.service.loadBalancerSourceRanges"
        value = var.ip_ranges_01
    }

    depends_on = [ 
      azurerm_kubernetes_cluster.icap-deploy,
    ]
  }

  # Deploy Cadvisor helm chart
  resource "helm_release" "cadvisor" {

    count = var.enable_helm_deployment ? 1 : 0

    name             = var.release_name10
    namespace        = var.namespace10
    create_namespace = true
    chart            = var.chart_path10
    wait             = true
    cleanup_on_fail  = true

    depends_on = [ 
      azurerm_kubernetes_cluster.icap-deploy,
    ]
  }

resource "null_resource" "get_kube_context" {

 provisioner "local-exec" {

    command = "az aks get-credentials --resource-group ${var.resource_group} --name ${var.cluster_name} --overwrite-existing"
  }
  
  depends_on = [
    azurerm_kubernetes_cluster.icap-deploy,
  ]
}

resource "null_resource" "load_k8_secrets" {

 provisioner "local-exec" {

    command = "/bin/bash ../../scripts/k8s_scripts/create-ns-docker-secret.sh ${var.storage_resource} ${var.kv_vault_name} ${var.cluster_name}"
  }

  depends_on = [
    null_resource.get_kube_context,
  ]
}

resource "null_resource" "add_apps_argo" {

  count = var.enable_argocd_pipeline ? 1 : 0

 provisioner "local-exec" {

    command = "/bin/bash ../../scripts/argocd_scripts/argocd-app-deploy.sh ${var.resource_group} ${var.cluster_name} ${var.region} ${var.suffix} ${var.revision} ${var.argocd_cluster_context}"
  }

  depends_on = [
    null_resource.get_kube_context,
  ]
}