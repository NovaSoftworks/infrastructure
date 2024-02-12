resource "azurerm_role_assignment" "k8s_acr_role" {
  principal_id         = azurerm_kubernetes_cluster.k8s.kubelet_identity.0.object_id
  role_definition_name = "AcrPull"
  scope                = var.acr_id
}
