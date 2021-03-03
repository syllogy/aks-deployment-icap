# Backend Storage for Statefile
terraform {
	backend "azurerm" {
	  
	}
}

# Cluster Modules
module "create_aks_cluster" {
	source					  =   "./modules/clusters/icap-cluster"

	resource_group            =   "icap-aks-rg-${var.suffix}"
	region                    =   var.azure_region
	cluster_name              =   "icap-aks-clu-${var.suffix}-${var.azure_region}"
	min_count				  =   "4"
	max_count				  =   "100"

	icap_port                 =   var.icap_port
	icap_tlsport              =   var.icap_tlsport
	dns_name_01               =   "icap-${var.suffix}"
	dns_name_04               =   "management-ui-${var.suffix}.${var.azure_region}.${var.domain}"
	a_record_01				  =   "management-ui-${var.suffix}"

	kv_vault_name             =    "icap-aks-kv-${var.suffix}"
	storage_resource          =    "icap-aks-storage-${var.suffix}"

	argocd_cluster_context	  =	   var.argocd_cluster_context
	revision 				  =	   var.revision
	suffix					  =    var.suffix

}

module "create_aks_cluster_file_drop" {
	source					  =   "./modules/clusters/file-drop-cluster"
	
	resource_group            =   "icap-fd-rg-${var.suffix}-${var.azure_region}"
	region                    =   var.azure_region
	cluster_name              =   "icap-fd-clu-${var.suffix}-${var.azure_region}"
	file_drop_dns_name_01     =   "file-drop-${var.suffix}.${var.azure_region}.${var.domain}"
	a_record_02				  =   "file-drop-${var.suffix}"

}

# Storage Account Modules
module "create_storage_account" {
	source					  =   "./modules/storage-account"
	
	resource_group		      =   "icap-aks-storage-${var.suffix}"
	region                    =   var.azure_region

}

# Key Vault Modules
module "create_key_vault" {
	source					  =   "./modules/keyvault"

	resource_group            =   "icap-aks-kv-rg-${var.suffix}"
	region                    =   var.azure_region
	kv_name                   =   "icap-aks-kv-${var.suffix}"
	icap_dns                  =   "icap-${var.suffix}.${var.azure_region}.${var.domain}"
	mgmt_dns                  =   "management-ui-${var.suffix}.${var.azure_region}.${var.domain}"
	file_drop_dns             =   "file-drop-${var.suffix}.${var.azure_region}.${var.domain}"

}
