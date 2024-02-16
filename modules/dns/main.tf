locals {
  component = "novacp-${var.environment}-${var.region_short}-dns"
}

resource "azurerm_resource_group" "dns_rg" {
  name     = "${local.component}-rg"
  location = var.region

  tags = {
    environment = var.environment
  }
}

resource "azurerm_dns_zone" "novasoftworks_com_zone" {
  name                = "novasoftworks.com"
  resource_group_name = azurerm_resource_group.dns_rg.name

  tags = {
    environment = var.environment
  }
}
