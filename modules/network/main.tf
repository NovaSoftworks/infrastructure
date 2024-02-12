locals {
  component = "novacp-${var.environment}-${var.region_short}-vnet"
}

resource "azurerm_resource_group" "vnet_rg" {
  name     = "${local.component}-rg"
  location = var.region
}

resource "azurerm_virtual_network" "vnet" {
  name                = local.component
  location            = azurerm_resource_group.vnet_rg.location
  resource_group_name = azurerm_resource_group.vnet_rg.name
  address_space       = ["10.0.0.0/8"]
}
