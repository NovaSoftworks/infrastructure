locals {
  kube_config = module.paas.paas_k8s.kube_config.0
}

output "dns_zone_novasoftworks_com" {
  value       = module.dns.dns_zone_novasoftworks_com
  description = "The DNS zone for the domain novasoftworks.com."
}

output "paas_k8s_host" {
  value     = local.kube_config.host
  sensitive = true
}

output "paas_k8s_client_certificate" {
  value     = base64decode(local.kube_config.client_certificate)
  sensitive = true
}

output "paas_k8s_client_key" {
  value     = base64decode(local.kube_config.client_key)
  sensitive = true
}

output "paas_k8s_cluster_ca_certificate" {
  value     = base64decode(local.kube_config.cluster_ca_certificate)
  sensitive = true
}
