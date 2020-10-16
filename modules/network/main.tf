# Create virtual network
resource "azurerm_virtual_network" "net_virtual_network" {
  name                = var.service_name
  address_space       = var.address_space
  location            = var.region
  resource_group_name = var.resource_group
}
