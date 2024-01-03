output "acr" {
  value       = module.container_registry.acr
  description = "The Azure Container Registry."
  sensitive   = true
}

output "app_service_plan" {
  value       = module.app_service_plan.app_service_plan
  description = "The App Service Plan."
}

output "dns_zone_novasoftworks_com" {
  value       = module.dns.dns_zone_novasoftworks_com
  description = "The DNS zone for the domain novasoftworks.com."
}
