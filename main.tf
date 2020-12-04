module "create_resource_group_UKSouth" {
	source						="./modules/resource-group01-uks"
}

module "create_aks_cluster_UKSouth" {
	source						="./modules/clusters/aks01-uks"
}

module "create_resource_group_NorthEurope" {
	source						="./modules/resource-group02-neu"
}

module "create_aks_cluster_NorthEurope" {
	source						="./modules/clusters/aks02-neu"
}

module "create_resource_group_USEast" {
	source						="./modules/resource-group03-useast"
}

module "create_aks_cluster_USEast" {
	source						="./modules/clusters/aks03-useast"
}

module "create_resource_group_QA-UKSouth" {
	source						="./modules/resource-group04-qa-uks"
}

module "create_aks_cluster_QA-UKSouth" {
	source						="./modules/clusters/aks04-qa-uks"
}

module "create_storage_account_NEU" {
	source						="./modules/storage-accounts/storage-account-neu"
}
