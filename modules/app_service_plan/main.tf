locals {
  component = "novacp-${var.environment}-${var.region_short}"
}

resource "azurerm_resource_group" "app-service-plan_rg" {
  name     = "${local.component}-app-service-plan-rg"
  location = var.region
}

resource "azurerm_service_plan" "app-service-plan" {
  name                = "${local.component}-app-service-plan"
  resource_group_name = azurerm_resource_group.app-service-plan_rg.name
  location            = azurerm_resource_group.app-service-plan_rg.location
  os_type             = "Linux"
  sku_name            = var.app_service_plan_vm_size
}
