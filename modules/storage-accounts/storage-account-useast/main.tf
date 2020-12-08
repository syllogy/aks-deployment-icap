resource "random_string" "name" {
  length  = 4
  special = false
  upper   = false
  lower   = false
}

# Create Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.region
}

# Create Storage Account
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

# Create file shares
resource "azurerm_storage_share" "transactions" {
  name                 = var.file_share_name01
  storage_account_name = azurerm_storage_account.transactions.name
  quota                = 100
}

resource "azurerm_storage_share" "policies" {
  name                 = var.file_share_name02
  storage_account_name = azurerm_storage_account.policies.name
  quota                = 100
}