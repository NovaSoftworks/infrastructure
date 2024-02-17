output "paas_k8s" {
  value       = azurerm_kubernetes_cluster.paas_k8s
  description = "The Kubernetes cluster of the PaaS."
}
