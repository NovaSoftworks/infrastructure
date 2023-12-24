output "acr" {
  value       = module.container_registry.acr
  description = "The Azure Container Registry."
  sensitive   = true
}
