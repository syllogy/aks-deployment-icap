
module "create_resource_group" {
	source						="./modules/resource-group"
}

module "create_acr" {
	source						= "./modules/acr"
}

module "create_aks_cluster" {
	source						="./modules/aks"
}

module "create_public_IP" {
	source						="./modules/public-ip"
}

module "create_subnet" {
	source						="./modules/subnet"
}

module "create_network" {
	source						="./modules/network"
}

#resource "azurerm_container_registry" "example" {
  # (resource arguments)
#}
