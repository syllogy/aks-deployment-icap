data "azurerm_client_config" "current" {
}

# Create resource group
resource "azurerm_resource_group" "keyvault" {
  name     = var.resource_group
  location = var.region
  
  tags = {
    created_by         = "Glasswall Solutions"
    deployment_version = "1.0.0"
  }
}

# Create Key Vault
resource "azurerm_key_vault" "keyvault" {
  name                        = var.kv_name
  location                    = azurerm_resource_group.keyvault.location
  resource_group_name         = azurerm_resource_group.keyvault.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "backup",
      "create",
      "decrypt",
      "delete",
      "encrypt",
      "get",
      "import",
      "list",
      "purge",
      "recover",
      "restore",
      "sign",
      "unwrapKey",
      "update",
      "verify",
      "wrapKey"
    ]

    secret_permissions = [
      "backup",
      "delete",
      "get",
      "list",
      "purge",
      "recover",
      "restore",
      "set"
    ]

    storage_permissions = [
      "get",
      "backup",
      "delete",
      "deletesas",
      "getsas",
      "list",
      "listsas",
      "purge",
      "recover",
      "regeneratekey",
      "restore",
      "set",
      "setsas",
      "update"
    ]

    certificate_permissions = [
      "backup",
      "create",
      "delete",
      "deleteissuers",
      "get",
      "getissuers",
      "import",
      "list",
      "listissuers",
      "managecontacts",
      "manageissuers",
      "purge",
      "recover",
      "restore",
      "setissuers",
      "update"
    ]
  }
}

resource "null_resource" "create_dirs" {

 provisioner "local-exec" {

    command = "/bin/bash ../../scripts/gen-certs/create-dirs.sh"
  }
}

resource "null_resource" "create_icap_certs" {

 provisioner "local-exec" {

    command = "/bin/bash ../../scripts/gen-certs/icap-gen-certs.sh ${var.icap_dns}"
  }

  depends_on = [ 
    null_resource.create_dirs,
   ]
}

resource "null_resource" "create_mgmt_certs" {

 provisioner "local-exec" {

    command = "/bin/bash ../../scripts/gen-certs/mgmt-gen-certs.sh ${var.mgmt_dns}"
  }
  
  depends_on = [ 
    null_resource.create_dirs,
   ]
}

resource "null_resource" "create_file_drop_certs" {

 provisioner "local-exec" {

    command = "/bin/bash ../../scripts/gen-certs/file-drop-certs.sh ${var.file_drop_dns}"
  }
  
  depends_on = [ 
    null_resource.create_dirs,
   ]
}

resource "null_resource" "load_secrets" {

 provisioner "local-exec" {

    command = "/bin/bash ../../scripts/az-secret-script/create-az-secret.sh ${var.kv_name}"
  }

  depends_on = [
    azurerm_key_vault.keyvault,
   ]
}