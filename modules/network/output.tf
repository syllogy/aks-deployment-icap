output "service_name" {
	value = "${azurerm_virtual_network.net_virtual_network.name}"
}

output "address_space" {
	value = "${azurerm_virtual_network.net_virtual_network.address_space}"
}

