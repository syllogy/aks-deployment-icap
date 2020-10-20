
module "create_resource_group" {
	source						="./modules/resource-group"
}

module "create_acr" {
	source						= "./modules/acr"
}

module "create_aks_cluster" {
	source						="./modules/aks"
}