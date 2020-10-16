resource "azurerm_kubernetes_cluster" "default" {
  name                = "${var.prefix}-aks"
  location            = var.region
  resource_group_name = var.resource_group 
  dns_prefix          = "${var.prefix}-k8s"

  default_node_pool {
    name            = "icaptestnode"
    node_count      = 2
    vm_size         = "Standard_D2_v2"
    os_disk_size_gb = 30
  }

  service_principal {
    client_id     = var.appId
    client_secret = var.password
  }

  role_based_access_control {
    enabled = true
  }

  tags = {
    created_by = "Mattp" 
  }
}