data "azurerm_key_vault" "keyvault" {
  name                = var.keyvault_name
  resource_group_name = var.vault_resourcegroup_name
}

data "azurerm_key_vault_secret" "spusername" {
  name         = var.secret_sp_1
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

data "azurerm_key_vault_secret" "sppassword" {
  name         = var.secret_sp_2
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

resource "azurerm_kubernetes_cluster" "icap-deploy" {
  name                = var.cluster_name
  location            = var.region
  resource_group_name = var.resource_group
  dns_prefix          = "${var.cluster_name}-k8s"

  default_node_pool {
    name            = var.node_name
    node_count      = 1
    vm_size         = "Standard_A4_v2"
    os_disk_size_gb = 40
  }

  service_principal {
    client_id     = data.azurerm_key_vault_secret.spusername.value
    client_secret = data.azurerm_key_vault_secret.sppassword.value
  }

  role_based_access_control {
    enabled = true
  }

  tags = {
    created_by = "Mattp" 
  }
}