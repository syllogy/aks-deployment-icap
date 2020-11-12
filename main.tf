
module "create_resource_group_UKSouth" {
	source						="./modules/resource-group01-uks"
}

module "create_aks_cluster_UKSouth" {
	source						="./modules/aks01-uks"
}

module "create_resource_group_NorthEurope" {
	source						="./modules/resource-group02-neu"
}

module "create_aks_cluster_NorthEurope" {
	source						="./modules/aks02-neu"
}

module "create_resource_group_USEast" {
	source						="./modules/resource-group03-useast"
}

module "create_aks_cluster_USEast" {
	source						="./modules/aks03-useast"
}