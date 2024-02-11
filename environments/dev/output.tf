output "acr" {
  value       = module.container_registry.acr
  description = "The Azure Container Registry."
  sensitive   = true
}

output "dns_zone_novasoftworks_com" {
  value       = module.dns.dns_zone_novasoftworks_com
  description = "The DNS zone for the domain novasoftworks.com."
}
