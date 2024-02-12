resource "azurerm_subnet" "k8s_subnet" {
  name                 = "k8s"
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.vnet_rg.name
  address_prefixes     = ["10.8.0.0/16"]
}

output "k8s_subnet_id" {
  value       = azurerm_subnet.k8s_subnet.id
  description = "The ID of the subnet to which the Kubernetes cluster will be connected."
}
