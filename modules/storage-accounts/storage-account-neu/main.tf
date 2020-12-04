resource "random_string" "name" {
  length  = 4
  special = false
  upper   = false
  lower   = false
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.region
}

resource "azurerm_storage_account" "storage_account" {
  name                     = "gwstorageacc${random_string.name.result}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Premium"
  account_replication_type = "LRS"

  tags = {
    environment = "test"
    created_by  = "Mattp"
  }
}