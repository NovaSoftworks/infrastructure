locals {
  component = "novacp-${var.environment}-${var.region_short}"
}

resource "azurerm_resource_group" "acr_rg" {
  name     = "${local.component}-acr-rg"
  location = var.region
}

resource "azurerm_container_registry" "acr" {
  name                = "novasoftworks"
  resource_group_name = azurerm_resource_group.acr_rg.name
  location            = azurerm_resource_group.acr_rg.location
  sku                 = "Basic"

  admin_enabled = true
}
