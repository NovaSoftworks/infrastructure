resource "azurerm_subnet" "paas_subnet" {
  name                 = "paas"
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.vnet_rg.name
  address_prefixes     = ["10.8.0.0/16"]
}

output "paas_subnet_id" {
  value       = azurerm_subnet.paas_subnet.id
  description = "The ID of the subnet to which the PaaS will be connected."
}
