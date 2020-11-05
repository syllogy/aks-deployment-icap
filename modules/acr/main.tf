
# resource "azurerm_resource_group" "resource_group" {
#   name     = var.service_name
#   location = var.region
# }

# resource "azurerm_container_registry" "acr" {
#   name                     = var.registry_name
#   resource_group_name      = azurerm_resource_group.resource_group.name
#   location                 = azurerm_resource_group.resource_group.location
#   sku                      = "Premium"
#   admin_enabled            = false
#   georeplication_locations = ["UKSouth", "West Europe"]
  
#   tags = {
#     created_by = "Mattp" 
#   }
# }
