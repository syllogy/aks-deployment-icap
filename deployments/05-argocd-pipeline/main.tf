# Backend Storage for Statefile
terraform {
	backend "azurerm" {
	  
	}
}

module "create_aks_cluster_argo" {
	source					  =   "./modules/clusters"

    resource_group            =   "icap-aks-rg-${var.suffix}"
	region                    =   var.azure_region
	cluster_name              =   "icap-aks-clu-${var.suffix}-${var.azure_region}"

	kv_vault_name             =    "icap-aks-kv-${var.suffix}"
	storage_resource          =    "icap-aks-storage-${var.suffix}"
}