output "dns_zone_novasoftworks_com" {
  value       = module.dns.dns_zone_novasoftworks_com
  description = "The DNS zone for the domain novasoftworks.com."
}

output "k8s" {
  value       = module.k8s.k8s
  description = "The Kubernetes cluster."
  sensitive   = true
}
