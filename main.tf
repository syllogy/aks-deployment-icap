# Backend Storage for Statefile
terraform {
  backend "azurerm" {
	resource_group_name  = "gw-icap-tfstate"
    storage_account_name = "tfstate263"
    container_name       = "gw-icap-tfstate"
    key                  = "terraform.tfstate"
  }
}

# Cluster Modules
module "create_aks_cluster_UKSouth" {
	source						="./modules/clusters/aks01-uks"
}

module "create_aks_cluster_file_drop_UKSouth" {
	source						="./modules/clusters/aks01-uks/file-drop-cluster"
}

module "create_aks_cluster_NorthEurope" {
	source						="./modules/clusters/aks02-neu"
}

module "create_aks_cluster_file_drop_NorthEurope" {
	source						="./modules/clusters/aks02-neu/file-drop-cluster"
}

module "create_aks_cluster_USEast" {
	source						="./modules/clusters/aks03-useast"
}

module "create_aks_cluster_QA-UKSouth" {
	source						="./modules/clusters/aks04-qa-uks"
}

module "create_aks_cluster_ARGOCD" {
	source						="./modules/clusters/argocd-command-cluster"
}

# Storage Account Modules
module "create_storage_account_NEU" {
	source						="./modules/storage-accounts/storage-account-neu"
}

module "create_storage_account_qa_UKS" {
	source						="./modules/storage-accounts/storage-account-qa-uks"
}

module "create_storage_account_UKS" {
	source						="./modules/storage-accounts/storage-account-uks"
}

module "create_storage_account_USEAST" {
	source						="./modules/storage-accounts/storage-account-useast"
}

# Key Vault Modules

module "create_key_vault_NEU" {
	source						="./modules/keyvaults/key-vault-neu"
}

module "create_key_vault_qa_UKS" {
	source						="./modules/keyvaults/key-vault-qa-uks"
}

module "create_key_vault_UKS" {
	source						="./modules/keyvaults/key-vault-uks"
}

module "create_key_vault_useast" {
	source						="./modules/keyvaults/key-vault-useast"
}