resource "azurerm_container_registry" "paas_acr" {
  name                = "${var.region_short}${var.environment}novasoftworks"
  resource_group_name = azurerm_resource_group.paas_rg.name
  location            = azurerm_resource_group.paas_rg.location
  sku                 = "Basic"

  admin_enabled = true

  tags = {
    environment = var.environment
  }
}

resource "azurerm_role_assignment" "paas_acr_role" {
  principal_id         = azurerm_kubernetes_cluster.paas_k8s.kubelet_identity[0].object_id
  role_definition_name = "AcrPull"
  scope                = azurerm_container_registry.paas_acr.id
}
